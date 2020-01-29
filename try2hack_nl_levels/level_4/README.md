# Level 4

## URL

```
http://www.try2hack.nl/levels/level4-kdnvxs.xhtml
```

## Solution

* At first, open the source code.

```
view-source:http://www.try2hack.nl/levels/level4-kdnvxs.xhtml
```

An Java class can be find here:

```
  <!--[if !IE]>-->
    <object classid="java:PasswdLevel4.class" type="application/x-java-applet" height="370" width="330" >
  <!--<![endif]-->
    <object classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" codebase="http://java.sun.com/update/1.6.0/jinstall-6u10-windows-i586.cab" height="370" width="330" >
      <param name="code" value="PasswdLevel4" />
    </object>
```

* Downloading the Java class file:

```
http://try2hack.nl/levels/PasswdLevel4.class
```

* Now is possible decompile the Java class.

* Looking up PasswdLevel4.java (already decompiled) is possible to see that an file called "level4" was included.

```
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
```

* Let's see level4 content

```
level5-fdvbdf.xhtml
appletking
pieceofcake
```

# Answer

```
URL: http://www.try2hack.nl/levels/level5-fdvbdf.xhtml
Username: appletking
Password: pieceofcake
```

