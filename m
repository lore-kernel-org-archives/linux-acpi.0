From: roychris <roychris-GANU6spQydw@public.gmane.org>
Subject: Re: SCI interrupt handler : spend too much time
Date: Thu, 04 Dec 2003 09:25:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FCEEF85.3050802@free.fr>
References: <3ACA40606221794F80A5670F0AF15F8401720BF7@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------030202020103090408080302"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720BF7-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030202020103090408080302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by esstin.uhp-nancy.fr id hB48TE7S007620

Personally, I think so.

Yu, Luming a =E9crit :

> Does it mean the overhead of SCI interrupt was not the root cause of=20
> this issue. --Luming
> =20
>
>     -----Original Message-----
>     *From:* roychris [mailto:roychris-GANU6spQydw@public.gmane.org]
>     *Sent:* 2003?12?3? 20:49
>     *To:* Pavel Machek
>     *Cc:* Yu, Luming; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>     *Subject:* Re: [ACPI] SCI interrupt handler : spend too much time
>
>     Just a precision,
>     synaptic driver is not like the other mouses. psmouse call a
>     specific fonction for this touchpad that is in an other module.
>     The problem happens since 2.6, since psmouse and synaptic had been
>     seperated....
>
>     Pavel Machek wrote:
>
>>Hi!
>>
>> =20
>>
>>>It sound like serious one, if SCI interrupt handler was blamed for
>>>this issue.     --Luming
>>>   =20
>>>
>>
>>I investigated a bit, and interrupt latency alone is not enough to
>>break mouse. [Unfortunately, I do not have easy/sure way to reproduce
>>it.]
>>
>>Is it possible that SCI interrupt handler accesses keyboard controller
>>(and breaks mouse?)
>>								Pavel
>>
>>
>>
>> =20
>>
>


--------------030202020103090408080302
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Personally, I think so.<br>
<br>
Yu, Luming a &eacute;crit&nbsp;:<br>
<blockquote type="cite"
 cite="mid3ACA40606221794F80A5670F0AF15F8401720BF7-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org">
  <meta content="text/html; " http-equiv="Content-Type">
  <title></title>
  <meta name="GENERATOR" content="MSHTML 6.00.2722.900">
  <div><span class="927474203-04122003"><font size="2" color="#0000ff"
 face="&#23435;&#20307;">Does it mean the overhead of SCI interrupt was not the root
cause of this issue. --Luming</font></span></div>
  <div><span class="927474203-04122003"></span>&nbsp;</div>
  <blockquote>
    <div align="left" dir="ltr" class="OutlookMessageHeader"><font
 size="2" face="Tahoma">-----Original Message-----<br>
    <b>From:</b> roychris [<a class="moz-txt-link-freetext" href="mailto:roychris-GANU6spQydw@public.gmane.org">mailto:roychris@free.fr</a>]<br>
    <b>Sent:</b> 2003&#24180;12&#26376;3&#26085; 20:49<br>
    <b>To:</b> Pavel Machek<br>
    <b>Cc:</b> Yu, Luming; <a class="moz-txt-link-abbreviated" href="mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">acpi-devel@lists.sourceforge.net</a><br>
    <b>Subject:</b> Re: [ACPI] SCI interrupt handler : spend too much
time<br>
    <br>
    </font></div>
Just a precision,<br>
synaptic driver is not like the other mouses. psmouse call a specific
fonction for this touchpad that is in an other module.<br>
The problem happens since 2.6, since psmouse and synaptic had been
seperated....<br>
    <br>
Pavel Machek wrote:<br>
    <blockquote type="cite"
 cite="mid20031203124720.GA11239-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org">
      <pre wrap="">Hi!

  </pre>
      <blockquote type="cite">
        <pre wrap="">It sound like serious one, if SCI interrupt handler was blamed for
this issue.     --Luming
    </pre>
      </blockquote>
      <pre wrap=""><!---->
I investigated a bit, and interrupt latency alone is not enough to
break mouse. [Unfortunately, I do not have easy/sure way to reproduce
it.]

Is it possible that SCI interrupt handler accesses keyboard controller
(and breaks mouse?)
								Pavel



  </pre>
    </blockquote>
    <br>
  </blockquote>
</blockquote>
<br>
</body>
</html>

--------------030202020103090408080302--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
