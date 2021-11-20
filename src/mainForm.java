import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jpl7.*;
import java.io.*;
import java.util.ArrayList;
import java.util.Map;

public class mainForm {
    private JButton Importar;
    private JButton foiComprado;
    private JButton totalDeComprasNaButton;
    private JButton quantidadeTotalButton;
    private JButton valorTotalDoProdutoButton;
    private JButton oQueFoiCompradoButton;
    private JTextField textComprado;
    private JButton produtoMaisCompradoButton;
    private JTextField textQtdTotal;
    private JTextField textValor;
    private JTextField textCompradoData;
    private JTextField totalComprasLoja;
    private JTextArea resultado;
    private JPanel painel;

    public static String BASE_DE_DADOS = null;

    public mainForm() {
        foiComprado.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Query q = new Query("consult('trabPara1.pl')");
                q.hasSolution();
                q = new Query("compramos('" + textComprado.getText() + "')");
                Map<String, Term>[] res = q.allSolutions();

                if(res.length >= 1) {
                    resultado.setText("Sim");
                } else {
                    resultado.setText("Não");
                }
            }
        });
        quantidadeTotalButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Query q = new Query("consult('trabPara1.pl')");
                q.hasSolution();
                q = new Query("quantos('" + textQtdTotal.getText() + "', X)");
                Map<String, Term>[] res = q.allSolutions();
                resultado.setText(res[0].get("X").toString());
            }
        });
        valorTotalDoProdutoButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Query q = new Query("consult('trabPara1.pl')");
                q.hasSolution();
                q = new Query("valor('" + textValor.getText() + "', X)");
                Map<String, Term>[] res = q.allSolutions();
                resultado.setText(res[0].get("X").toString());
            }
        });
        oQueFoiCompradoButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Query q = new Query("consult('trabPara1.pl')");
                q.hasSolution();
                q = new Query("comprado_em('" + textCompradoData.getText() + "', X)");
                Map<String, Term>[] res = q.allSolutions();
                for (int i = 0; i < res.length; i++) {
                    System.out.println(res[i].get("X").toString());
                }
            }
        });
        totalDeComprasNaButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Query q = new Query("consult('trabPara1.pl')");
                q.hasSolution();
                q = new Query("compra_na_loja('" + totalComprasLoja.getText() + "', X)");
                Map<String, Term>[] res = q.allSolutions();
                resultado.setText(res[0].get("X").toString());
            }
        });
        Importar.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JOptionPane.showMessageDialog(null, "Selecione a planilha.");
                JFileChooser chooser = new JFileChooser();
                FileNameExtensionFilter filter = new FileNameExtensionFilter("xlsx", "xlsx");
                chooser.setFileFilter(filter);
                int returnVal = chooser.showOpenDialog(null);
                if (returnVal == JFileChooser.APPROVE_OPTION) {
                    try {
                        adicionarFatosNaBaseDeDados(lerXml(chooser.getSelectedFile().getAbsolutePath()));
                    } catch (IOException ex) {
                        ex.printStackTrace();
                    }
                }
            }
        });
    }

    public static void main (String[] args) {
        JFrame frame = new JFrame("App");
        frame.setContentPane(new mainForm().painel);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

        JOptionPane.showMessageDialog(null, "Selecione a base de dados.");
        JFileChooser chooser = new JFileChooser();
        FileNameExtensionFilter filter = new FileNameExtensionFilter("pl", "pl");
        chooser.setFileFilter(filter);
        int returnVal = chooser.showOpenDialog(null);
        if (returnVal == JFileChooser.APPROVE_OPTION) {
            BASE_DE_DADOS = chooser.getSelectedFile().getAbsolutePath();
        }
    }

    public ArrayList<String> lerXml(String caminho) {
        //obtaining input bytes from a file
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(new File(caminho));
        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        }
        //creating workbook instance that refers to .xls file
        Workbook wb = null;
        try {
            wb = new XSSFWorkbook(fis);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        //creating a Sheet object to retrieve the object
        Sheet sheet = wb.getSheetAt(0);
        //evaluating cell type
        FormulaEvaluator formulaEvaluator=wb.getCreationHelper().createFormulaEvaluator();

        ArrayList<String> fatos = new ArrayList<>();
        String fato = "gasto(";
        int contCells = 0;
        int contRolls = 0;

        //iterando sobre o xml e pegando todos os fatos
        for(Row row: sheet)     //iteration over row using for each loop
        {
            if(contRolls == 0) {
                contRolls++;
            }  else {
                for(Cell cell: row)    //iteration over cell using for each loop
                {
                    if(contCells == 0) {
                        contCells++;
                    } else {
                        fato = fato.concat(", ");
                    }
                    switch(formulaEvaluator.evaluateInCell(cell).getCellType())
                    {
                        case Cell.CELL_TYPE_NUMERIC:   //field that represents numeric cell type
                            //getting the value of the cell as a number
                            fato = fato.concat(String.valueOf(cell.getNumericCellValue()));
                            break;
                        case Cell.CELL_TYPE_STRING:    //field that represents string cell type
                            //getting the value of the cell as a string
                            fato = fato.concat("'");
                            fato = fato.concat(cell.getStringCellValue());
                            fato = fato.concat("'");
                            break;
                    }
                }
                contCells = 0;
                fato = fato.concat(").");
                System.out.println(fato);
                fatos.add(fato);
                fato = "gasto(";
            }
        }
        return fatos;
    }

    public void adicionarFatosNaBaseDeDados(ArrayList<String> fatos) throws IOException {
        FileWriter fw = new FileWriter(BASE_DE_DADOS, true);
        for (String f: fatos) {
            fw.write(System.getProperty( "line.separator" ));
            fw.write(f);
        }
        fw.close();
        JOptionPane.showMessageDialog(null, "Planilha importada com sucesso!!");
    }
}

