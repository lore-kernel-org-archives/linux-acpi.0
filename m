From: Peter.Zeipelt-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org
Subject: Re: No network after S3
Date: Mon, 16 Feb 2004 12:02:29 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076928345.40309f590d1ab@webmail.t-online.de>
References: <BF1FE1855350A0479097B3A0D2A80EE0025A6344@hdsmsx402.hd.intel.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0025A6344-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yes, it's right.
The mentioned NIC's are working under normal condition.
Of course, the first ping took almost a second.
But that isn't such a great problem for me,  that I have to look for
the reason now.
But again.
Before S3 the NIC is working.
Unloading the module before and reloading it after  suspending 
brings no success.
Even if the module isn't loaded before S3 and loaded after the wakeup
makes no difference.
And the problem is only after S3.
If I send the system to S4 and wake it up, the NIC is working.
But for the things I want to do (i.e. Fax-Services and answering
machine) the boottime
after S4 is to long.
And as mentioned in my first posting.
It makes no difference, if the NIC-driver is a module or compiled into
the kernel.
And the problem isn't specific on the ABIT-board with via chipset.
The same problem appears on an ASUS board with nforce2.
Unfortunately if have no modern board with  Intel chipset.

I hope, these informations are useful.
Many thanks for your help

Peter

Brown, Len schrieb:
> >I tried pci=noacpi. No diference.
> >If I understand you right, I should wait a little bit
> before dealing
> >with this powersaving stuff.
> 
> If the NIC were now working before attempting
> suspend/resume, then we'd
> need to get that fixed first.  However, I think you're
> saying that the
> NIC _does_ work under normal conditions, and the failure
> is only after
> returning from S3. yes?
> 
> So this seems suspend/resume specific, and your use of
> pci=noacpi
> further suggests it has nothing to do with the initial
> interrupt
> assignments.
> 
> We've got a number of post-resume failures, and this
> issue is rising on
> the priority list -- so I expect we'll spend some time
> looking at it
> soon.
> 
> Here's a bugzilla query of component=ACPI with the word
> "suspend".  I
> apologize in advance if outlook wraps this url on you...
> 
>
http://bugzilla.kernel.org/buglist.cgi?short_desc_type=allwordssubstr&sh
>
ort_desc=&component=ACPI&long_desc_type=allwordssubstr&long_desc=suspend
>
&kernel_version_type=allwordssubstr&kernel_version=&bug_status=NEW&bug_s
>
tatus=ASSIGNED&bug_status=RESOLVED&emailassigned_to1=1&emailtype1=substr
>
ing&email1=&emailassigned_to2=1&emailreporter2=1&emailcc2=1&emailtype2=s
>
ubstring&email2=&bugidtype=include&bug_id=&changedin=&chfieldfrom=&chfie
>
ldto=Now&chfieldvalue=&cmdtype=doit&namedcmd=component%3DACPI&newqueryna
>
me=&order=Reuse+same+sort+as+last+time&field0-0-0=noop&type0-0-0=noop&va
> lue0-0-0=
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id56&alloc_id438&oplick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
