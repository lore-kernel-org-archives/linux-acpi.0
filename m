From: roychris <roychris-GANU6spQydw@public.gmane.org>
Subject: Re: SCI interrupt handler : spend too much time
Date: Mon, 08 Dec 2003 11:00:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FD44BB5.407@free.fr>
References: <571ACEFD467F7749BC50E0A98C17CDD8E84E1B@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------090603010900080602030500"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD8E84E1B-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090603010900080602030500
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by esstin.uhp-nancy.fr id hB8A4N7S021173

Hi,
Sorry, it doesn't resolve my problem.

Li, Shaohua a =A8=A6crit:

>Hi,
>As I knew, some systems use keyboard controller to implement EC (I'm not=
 sure, but some materials said). Maybe the error it's caused by EC, so I =
recommend you to try the patch in http://bugme.osdl.org/show_bug.cgi?id=3D=
1433.=20
>
>Thanks,
>Shaohua
>
>
> =20
>
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Yu, Luming
>>Sent: 2003=C4=EA12=D4=C28=C8=D5 11:21
>>To: Pavel Machek
>>Cc: roychris; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: RE: [ACPI] SCI interrupt handler : spend too much time
>>
>>To SCI handler itself,  I don't think keyboard controller will be touch=
ed.
>>But SCI handler could evaluate some AML method which could touch keyboa=
rd
>>controller. --Luming
>>
>>-----Original Message-----
>>From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]
>>Sent: 2003?12?4? 17:53
>>To: Yu, Luming
>>Cc: roychris; Pavel Machek; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: Re: [ACPI] SCI interrupt handler : spend too much time
>>
>>
>>Hi!
>>
>>   =20
>>
>>>   Does it mean the overhead of SCI interrupt was not the root cause o=
f
>>>   this issue. --Luming
>>>     =20
>>>
>>It certainly looks so. Is it possible that SCI handler touches
>>keyboard controller?
>>
>>--
>>Horseback riding is like software...
>>...vgf orggre jura vgf serr.
>>
>>
>>-------------------------------------------------------
>>This SF.net email is sponsored by: SF.net Giveback Program.
>>Does SourceForge.net help you be more productive?  Does it
>>help you create better code?  SHARE THE LOVE, and help us help
>>YOU!  Click Here: http://sourceforge.net/donate/
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>   =20
>>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: SF.net Giveback Program.
>Does SourceForge.net help you be more productive?  Does it
>help you create better code?  SHARE THE LOVE, and help us help
>YOU!  Click Here: http://sourceforge.net/donate/
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
> =20
>


--------------090603010900080602030500
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by esstin.uhp-nancy.fr id hB8A4N7S021173

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv=3D"Content-Type" content=3D"text/html;charset=3DGB2312=
">
  <title></title>
</head>
<body text=3D"#000000" bgcolor=3D"#ffffff">
Hi,<br>
Sorry, it doesn't resolve my problem.<br>
<br>
Li, Shaohua a =A8=A6crit&nbsp;:<br>
<blockquote type=3D"cite"
 cite=3D"mid571ACEFD467F7749BC50E0A98C17CDD8E84E1B-SRlDPOYGfgogGBtAFL8yw6lpV8nVzFHe@public.gmane.org=
el.com">
  <pre wrap=3D"">Hi,
As I knew, some systems use keyboard controller to implement EC (I'm not =
sure, but some materials said). Maybe the error it's caused by EC, so I r=
ecommend you to try the patch in <a class=3D"moz-txt-link-freetext" href=3D=
"http://bugme.osdl.org/show_bug.cgi?id=3D1433">http://bugme.osdl.org/show=
_bug.cgi?id=3D1433</a>.=20

Thanks,
Shaohua


  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">-----Original Message-----
From: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:acpi-devel-adm=
in-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">acpi-devel-admin@lists.sourceforge.net</a> [<a =
class=3D"moz-txt-link-freetext" href=3D"mailto:acpi-devel">mailto:acpi-de=
vel</a>-
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:admin-5NWGOfrQmnetEtDZOKyKiw@public.gmane.org=
rge.net">admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>] On Behalf Of Yu, Luming
Sent: 2003=C4=EA12=D4=C28=C8=D5 11:21
To: Pavel Machek
Cc: roychris; <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:acpi-d=
evel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">acpi-devel@lists.sourceforge.net</a>
Subject: RE: [ACPI] SCI interrupt handler : spend too much time

To SCI handler itself,  I don't think keyboard controller will be touched.
But SCI handler could evaluate some AML method which could touch keyboard
controller. --Luming

-----Original Message-----
From: Pavel Machek [<a class=3D"moz-txt-link-freetext" href=3D"mailto:pav=
el-+ZI9xUNit7I@public.gmane.org">mailto:pavel@ucw.cz</a>]
Sent: 2003?12?4? 17:53
To: Yu, Luming
Cc: roychris; Pavel Machek; <a class=3D"moz-txt-link-abbreviated" href=3D=
"mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">acpi-devel@lists.sourceforge.ne=
t</a>
Subject: Re: [ACPI] SCI interrupt handler : spend too much time


Hi!

    </pre>
    <blockquote type=3D"cite">
      <pre wrap=3D"">   Does it mean the overhead of SCI interrupt was no=
t the root cause of
   this issue. --Luming
      </pre>
    </blockquote>
    <pre wrap=3D"">It certainly looks so. Is it possible that SCI handler=
 touches
keyboard controller?

--
Horseback riding is like software...
...vgf orggre jura vgf serr.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: <a class=3D"moz-txt-link-freetext" href=3D"http://sourc=
eforge.net/donate/">http://sourceforge.net/donate/</a>
_______________________________________________
Acpi-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Acpi-devel-5NWGOfrQmneHXe+LvDLADg@public.gmane.org=
rceforge.net">Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/=
lists/listinfo/acpi-devel">https://lists.sourceforge.net/lists/listinfo/a=
cpi-devel</a>
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->

-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: <a class=3D"moz-txt-link-freetext" href=3D"http://sourc=
eforge.net/donate/">http://sourceforge.net/donate/</a>
_______________________________________________
Acpi-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Acpi-devel-5NWGOfrQmneHXe+LvDLADg@public.gmane.org=
rceforge.net">Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/=
lists/listinfo/acpi-devel">https://lists.sourceforge.net/lists/listinfo/a=
cpi-devel</a>


  </pre>
</blockquote>
<br>
</body>
</html>

--------------090603010900080602030500--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
