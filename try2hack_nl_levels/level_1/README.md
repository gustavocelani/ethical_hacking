# Level 1

## URL

```
http://www.try2hack.nl/levels/
```

## Solution

Open source of page and the password will be hardcoded in there:

```
    <script type="text/javascript">
      <!--
      function Try(passwd) {
        if (passwd =="h4x0r") {
          alert("Alright! On to level 2...");
          location.href = "level2-xfdgnh.xhtml";
        }
        else {
          alert("The password is incorrect. Please don't try again.");
          location.href = "http://www.disney.com/";
        }
      }
      //-->
    </script>
```

## Answer

```
Password: h4x0r
```

