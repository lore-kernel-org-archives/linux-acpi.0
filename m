From: roychris <roychris-GANU6spQydw@public.gmane.org>
Subject: Re: Fan control for my Dell SmartPC
Date: Mon, 26 May 2003 17:49:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ED23785.6020103@free.fr>
References: <001201c32391$ecc1cda0$354425db@sayonara>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------000304040706040408020903"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <001201c32391$ecc1cda0$354425db-F8JvWDuGsZU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Adachi, Kenichi" <aileenja_jpn-xFOqZoH7zVZ4Eiagz67IpQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000304040706040408020903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have a complement :

"it seems like the fan stuff is on the SMBus which is at address 7A. The 
speed can be read from register 11 and written to register 10."
I don't know how to use this information.

Adachi, Kenichi wrote:

>Hi, 
>
>  
>
>>There isn't any method to control the Fan in the dsdt ACPI 
>>table on my 
>>computer (DELL SmartPC/SmartStep).
>>Thanks to the ACPI Specs, I have implemented this code and 
>>there is no 
>>problem with the compilation. ACPI Linux driver indicates me that it 
>>finds a method for my two logical fans (one fan with 2 speeds). But I 
>>think that the adress (the namespace maybe EC0) is not good 
>>so I can't 
>>control it. How can I find the good region for my fan ?
>>    
>>
>
>Can you be more specific here:
>
>- What was the original status/problem? (There was nothing w.r.t. Fan
>control at all in your original DSDT, but your machine has been kept
>chilled by Fan, correct?)
>- What steps did you go through? (Trying to control Fan via ACPI by
>adding your own methods without knowledge as to how your Embedded
>Controller interacts with Fan controller etc.?)
>
>The entire DSDT, both original and modified, will be required for
>further investigation, but honestly speaking, there's little, if any,
>hope of success...
>
>Thanks,
>- Adachi, Kenichi 
>
>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: ObjectStore.
>If flattening out C++ or Java code to make your application fit in a
>relational database is painful, don't do it! Check out ObjectStore.
>Now part of Progress Software. http://www.objectstore.net/sourceforge
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
>  
>


--------------000304040706040408020903
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
I have a complement :<br>
<br>
"it seems like the fan stuff is on the SMBus which is at address 7A.
The speed can be read from register 11 and written to register 10."<br>
I don't know how to use this information.<br>
<br>
Adachi, Kenichi wrote:<br>
<blockquote type="cite"
 cite="mid001201c32391$ecc1cda0$354425db@sayonara">
  <pre wrap="">Hi, 

  </pre>
  <blockquote type="cite">
    <pre wrap="">There isn't any method to control the Fan in the dsdt ACPI 
table on my 
computer (DELL SmartPC/SmartStep).
Thanks to the ACPI Specs, I have implemented this code and 
there is no 
problem with the compilation. ACPI Linux driver indicates me that it 
finds a method for my two logical fans (one fan with 2 speeds). But I 
think that the adress (the namespace maybe EC0) is not good 
so I can't 
control it. How can I find the good region for my fan ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Can you be more specific here:

- What was the original status/problem? (There was nothing w.r.t. Fan
control at all in your original DSDT, but your machine has been kept
chilled by Fan, correct?)
- What steps did you go through? (Trying to control Fan via ACPI by
adding your own methods without knowledge as to how your Embedded
Controller interacts with Fan controller etc.?)

The entire DSDT, both original and modified, will be required for
further investigation, but honestly speaking, there's little, if any,
hope of success...

Thanks,
- Adachi, Kenichi 





-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. <a class="moz-txt-link-freetext" href="http://www.objectstore.net/sourceforge">http://www.objectstore.net/sourceforge</a>
_______________________________________________
Acpi-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">Acpi-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/acpi-devel">https://lists.sourceforge.net/lists/listinfo/acpi-devel</a>


  </pre>
</blockquote>
<br>
</body>
</html>

--------------000304040706040408020903--



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
