From: roychris <roychris-GANU6spQydw@public.gmane.org>
Subject: Re: SCI interrupt handler : spend too much time
Date: Wed, 03 Dec 2003 13:41:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FCDD9F6.2010401@free.fr>
References: <3ACA40606221794F80A5670F0AF15F8401720BEF@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------060106030203060600050609"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720BEF-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: pavel-+ZI9xUNit7I@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060106030203060600050609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have contacted the developper of synaptic driver, and for sure it's 
the fault of SCI interrupt handler.
I can reproduce it because I never lose sync when I don't access to 
/proc/.../temperature and when I access it, exactly at the same time, I 
lose the sync.

Yu, Luming wrote:

>It sound like serious one, if SCI interrupt handler was blamed for this issue.     --Luming
>
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-admin@lists.sourceforge.net]On Behalf Of Pavel Machek
>Sent: 2003?12?2? 2:28
>To: roychris
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] SCI interrupt handler : spend too much time
>
>
>Hi!
>
>  
>
>>Since 2.6, when I read /proc/acpi/thermal/THR*/temperature and battery
>>info, my system spends too much time in SCI interrupt handler and it
>>loses the sync of my mouse, a synaptic. Any issue ?
>>    
>>
>
>Can you repeat it? Losing sync of mouse is probably a bug in inputs,
>and should be fixed.
>								Pavel
>  
>


--------------060106030203060600050609
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
<meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
<title></title>
I have contacted the developper of synaptic driver, and for sure it's
the fault of SCI interrupt handler.<br>
I can reproduce it because I never lose sync when I don't access to
/proc/.../temperature and when I access it, exactly at the same time, I
lose the sync.<br>
<br>
Yu, Luming wrote:<br>
<blockquote
 cite="mid3ACA40606221794F80A5670F0AF15F8401720BEF-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org"
 type="cite">
  <pre wrap="">It sound like serious one, if SCI interrupt handler was blamed for this issue.     --Luming

-----Original Message-----
From: <a
 href="mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
 class="moz-txt-link-abbreviated">acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a> [<a
 href="mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
 class="moz-txt-link-freetext">mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>]On Behalf Of Pavel Machek
Sent: 2003?12?2? 2:28
To: roychris
Cc: <a
 href="mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
 class="moz-txt-link-abbreviated">acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>
Subject: Re: [ACPI] SCI interrupt handler : spend too much time


Hi!

  </pre>
  <blockquote type="cite">
    <pre wrap="">Since 2.6, when I read /proc/acpi/thermal/THR*/temperature and battery
info, my system spends too much time in SCI interrupt handler and it
loses the sync of my mouse, a synaptic. Any issue ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Can you repeat it? Losing sync of mouse is probably a bug in inputs,
and should be fixed.
								Pavel
  </pre>
</blockquote>
<br>
</body>
</html>

--------------060106030203060600050609--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
