import java.applet.Applet;
import java.awt.Button;
import java.awt.Component;
import java.awt.Container;
import java.awt.Font;
import java.awt.Label;
import java.awt.TextField;
import java.awt.event.ActionEvent;
import java.io.BufferedReader;
import java.net.MalformedURLException;
import java.net.URL;

public class PasswdLevel4 extends Applet implements java.awt.event.ActionListener
{
  private URL finalurl;
  String infile;
  String[] inuser = new String[22];
  int totno = 0;
  java.io.InputStream countConn = null;
  BufferedReader countData = null;
  URL inURL = null;
  TextField txtlogin = new TextField();
  Label label1 = new Label();
  Label label2 = new Label();
  Label label3 = new Label();
  TextField txtpass = new TextField();
  Label lblstatus = new Label();
  Button ButOk = new Button();
  Button ButReset = new Button();
  Label lbltitle = new Label();
  
  public PasswdLevel4() {}
  
  void ButOk_ActionPerformed(ActionEvent paramActionEvent) {
    int i = 0;
    for (int j = 1; j <= totno / 2; j++) {
      if ((txtlogin.getText().trim().toUpperCase().intern() == inuser[(2 * (j - 1) + 2)].trim().toUpperCase().intern()) && (txtpass.getText().trim().toUpperCase().intern() == inuser[(2 * (j - 1) + 3)].trim().toUpperCase().intern()))
      {
        lblstatus.setText("Login Success, Loading..");
        i = 1;
        String str1 = inuser[1].trim().intern();
        String str2 = getParameter("targetframe");
        if (str2 == null) {
          str2 = "_self";
        }
        try {
          finalurl = new URL(getCodeBase(), str1);
        }
        catch (MalformedURLException localMalformedURLException)
        {
          lblstatus.setText("Bad URL");
        }
        getAppletContext().showDocument(finalurl, str2);
      }
    }
    if (i == 0) {
      lblstatus.setText("Invaild Login or Password");
    }
  }
  
  void ButReset_ActionPerformed(ActionEvent paramActionEvent) {
    txtlogin.setText("");
    txtpass.setText("");
  }
  
  public void actionPerformed(ActionEvent paramActionEvent)
  {
    Object localObject = paramActionEvent.getSource();
    if (localObject == ButOk) {
      ButOk_ActionPerformed(paramActionEvent);
    }
    else if (localObject == ButReset) {
      ButReset_ActionPerformed(paramActionEvent);
    }
  }
  
  public void destroy() {
    ButOk.setEnabled(false);
    ButReset.setEnabled(false);
    txtlogin.setVisible(false);
    txtpass.setVisible(false);
  }
  
  public void inFile()
  {
    new StringBuffer();
    

    try
    {
      countConn = inURL.openStream();
      countData = new BufferedReader(new java.io.InputStreamReader(countConn));
      String str;
      while ((str = countData.readLine()) != null) {
        if (totno < 21)
        {
          totno += 1;
          inuser[totno] = str;
          str = "";

        }
        else
        {
          lblstatus.setText("Cannot Exceed 10 users, Applet fail start!");
          destroy();
        }
      }
    }
    catch (java.io.IOException localIOException1)
    {
      getAppletContext().showStatus("IO Error:" + localIOException1.getMessage());
    }
    try
    {
      countConn.close();
      countData.close();
    }
    catch (java.io.IOException localIOException2)
    {
      getAppletContext().showStatus("IO Error:" + localIOException2.getMessage());
    }
  }
  
  public void init()
  {
    setLayout(null);
    setSize(361, 191);
    add(txtlogin);
    txtlogin.setBounds(156, 72, 132, 24);
    label1.setText("Please Enter Login Name & Password");
    label1.setAlignment(1);
    add(label1);
    label1.setFont(new Font("Dialog", 1, 12));
    label1.setBounds(41, 36, 280, 24);
    label2.setText("Login");
    add(label2);
    label2.setFont(new Font("Dialog", 1, 12));
    label2.setBounds(75, 72, 36, 24);
    label3.setText("Password");
    add(label3);
    add(txtpass);
    txtpass.setEchoChar('*');
    txtpass.setBounds(156, 108, 132, 24);
    lblstatus.setAlignment(1);
    label3.setFont(new Font("Dialog", 1, 12));
    label3.setBounds(75, 108, 57, 21);
    add(lblstatus);
    lblstatus.setFont(new Font("Dialog", 1, 12));
    lblstatus.setBounds(14, 132, 344, 24);
    ButOk.setLabel("OK");
    add(ButOk);
    ButOk.setFont(new Font("Dialog", 1, 12));
    ButOk.setBounds(105, 156, 59, 23);
    ButReset.setLabel("Reset");
    add(ButReset);
    ButReset.setFont(new Font("Dialog", 1, 12));
    ButReset.setBounds(204, 156, 59, 23);
    lbltitle.setAlignment(1);
    add(lbltitle);
    lbltitle.setFont(new Font("Dialog", 1, 12));
    lbltitle.setBounds(12, 14, 336, 24);
    String str = getParameter("title");
    lbltitle.setText(str);
    ButOk.addActionListener(this);
    ButReset.addActionListener(this);
    infile = new String("level4");
    try
    {
      inURL = new URL(getCodeBase(), infile);
    }
    catch (MalformedURLException localMalformedURLException)
    {
      getAppletContext().showStatus("Bad Counter URL:" + inURL);
    }
    inFile();
  }
}
