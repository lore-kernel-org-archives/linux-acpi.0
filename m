From: roychris <roychris-GANU6spQydw@public.gmane.org>
Subject: Re: SCI interrupt handler : spend too much time
Date: Mon, 08 Dec 2003 11:05:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FD44CFD.30209@free.fr>
References: <3ACA40606221794F80A5670F0AF15F8401720C04@PDSMSX403.ccr.corp.intel.com> <20031208091937.GB241@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------060300050209000209090003"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031208091937.GB241-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300050209000209090003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by esstin.uhp-nancy.fr id hB8A9q7S021536

Hi,
I have no rule about mouse or keyboard in my aml code.
Pavel Machek a =E9crit :

>Hi!
>
> =20
>
>>To SCI handler itself,  I don't think keyboard controller will be touch=
ed. But SCI handler could evaluate some AML method which could touch keyb=
oard controller. --Luming
>>
>>   =20
>>
>
>Would that be a bug in AML method? Or how is keyboard-controller
>access locked between OS and ACPI?
>									Pavel
>
> =20
>
>>>   Does it mean the overhead of SCI interrupt was not the root cause o=
f
>>>   this issue. --Luming
>>>     =20
>>>
>>It certainly looks so. Is it possible that SCI handler touches
>>keyboard controller?
>>
>>   =20
>>
>
> =20
>


--------------060300050209000209090003
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Hi,<br>
I have no rule about mouse or keyboard in my aml code.<br>
Pavel Machek a &eacute;crit&nbsp;:<br>
<blockquote type="cite" cite="mid20031208091937.GB241-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org">
  <pre wrap="">Hi!

  </pre>
  <blockquote type="cite">
    <pre wrap="">To SCI handler itself,  I don't think keyboard controller will be touched. But SCI handler could evaluate some AML method which could touch keyboard controller. --Luming

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Would that be a bug in AML method? Or how is keyboard-controller
access locked between OS and ACPI?
									Pavel

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">   Does it mean the overhead of SCI interrupt was not the root cause of
   this issue. --Luming
      </pre>
    </blockquote>
    <pre wrap="">It certainly looks so. Is it possible that SCI handler touches
keyboard controller?

    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
</blockquote>
<br>
</body>
</html>

--------------060300050209000209090003--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
