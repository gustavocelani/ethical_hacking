# Level 3

## URL

```
http://www.try2hack.nl/levels/level3-.xhtml
```

## Solution

* At first, open the source code.

```
view-source:http://www.try2hack.nl/levels/level3-.xhtml
```

An fake JavaScript code can be find here:

```
    <script type="text/javascript" src="JavaScript"></script>
    <script type="text/javascript">
      <!--
      pwd = prompt("Please enter the password for level 3:","");
      if (pwd==PASSWORD){
        alert("Allright!\nEntering Level 4 ...");
        location.href = CORRECTSITE;
      }
      else {
        alert("WRONG!\nBack to disneyland !!!");
        location.href = WRONGSITE;
      }
      PASSWORD="AbCdE";
      CORRECTSITE="level4-sfvfxc.xhtml";
      WRONGSITE="http://www.disney.com";
      //-->
    </script>
```

* The real code are in sorce file "JavaScript", let's open it:

```
http://try2hack.nl/levels/JavaScript
```

JavaScript content:

```
PASSWORD = "try2hackrawks";
CORRECTSITE = "level4-kdnvxs.xhtml";
WRONGSITE = "http://www.disney.com";
```

## Answer

```
Password: try2hackrawks
```

