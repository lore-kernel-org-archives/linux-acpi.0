From: roychris <roychris-GANU6spQydw@public.gmane.org>
Subject: Re: SCI interrupt handler : spend too much time
Date: Wed, 03 Dec 2003 13:49:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FCDDBC0.8010009@free.fr>
References: <3ACA40606221794F80A5670F0AF15F8401720BEF@pdsmsx403.ccr.corp.intel.com> <20031203124720.GA11239@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------090008090002030306000403"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031203124720.GA11239-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
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
--------------090008090002030306000403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Just a precision,
synaptic driver is not like the other mouses. psmouse call a specific 
fonction for this touchpad that is in an other module.
The problem happens since 2.6, since psmouse and synaptic had been 
seperated....

Pavel Machek wrote:

>Hi!
>
>  
>
>>It sound like serious one, if SCI interrupt handler was blamed for
>>this issue.     --Luming
>>    
>>
>
>I investigated a bit, and interrupt latency alone is not enough to
>break mouse. [Unfortunately, I do not have easy/sure way to reproduce
>it.]
>
>Is it possible that SCI interrupt handler accesses keyboard controller
>(and breaks mouse?)
>								Pavel
>
>
>
>  
>


--------------090008090002030306000403
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
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
</body>
</html>

--------------090008090002030306000403--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
