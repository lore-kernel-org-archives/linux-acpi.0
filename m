From: Dom <dom-K271P2BsTd0@public.gmane.org>
Subject: Re: Re: IBM Thinkpad A31 | ACPI problems
Date: Sat, 4 Jan 2003 11:53:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301041153.42326.dom@wahuu.at>
References: <000301c2b284$8a15d8f0$232202d3@sayonara> <004701c2b2a6$434732d0$0201a8c0@csn.tuchemnitz.de> <200301022254.55856.dom@wahuu.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200301022254.55856.dom-K271P2BsTd0@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Thinkpad dudes out there,

1.) the following message was posted by an IBM employee on 
http://www7.pc.ibm.com/~Thinkpad

------------------
Topic: ACPI Linux (2 of 2), Read 6 times  
Conf: ThinkPad A20,A21,A22,A30,A31 
From: Theresa@IBM2 
Date: Friday, January 03, 2003 02:27 PM 
Hello Dom,
Unfortunately, we do not have any information on whether or not the BIOS will 
be updated to resolve the issue you are having with the ACPI. This is up to 
the IBM Software Developers.
 
Thank you for choosing the IBM Forums.
 
 
 Theresa L. IBM World-Wide Electronic Support and Services
---------------------

2.) thats the reply to my email sent to IBM technical support:

--------------------
Dear Mr. Bar,
you have contacted the technical support of IBM and we can't give you
marketing informations about future equipment. Please call our service
centre at 01803 - 31 32 33 and ask for someone who is able to inform you
about that.

Best regards
Your IBM eSupport



                         IBM Personal Computing Division
                         http://www.ibm.com/pc/support
--------------------

I will try to contact a developer at IBM ...

Greetings,
Dom

On Thursday 02 January 2003 22:54, Dom wrote:
> Dear Sandro,
>
> I posted the following message to the "Thinkpad A20,A21,A22,A30,A31" forum
> at IBM. Currently it looks like the posting has not been opened to public
> yet? I hope that IBM will provide a patch or that we can assist in creating
> a work around for the buggy bios. I know several friends who are running
> Linux on their A31's. Currently we all stick to kernel 2.4.19 +
> acpi-20020918 patch. This combination provides at least some support for
> ACPI.
>
> Thanks to the hard-working acpi-development team!
> Dom
>
> --------
> Topic:      ACPI Linux (1 of 1), Read 10 times
> Conf: ThinkPad A20,A21,A22,A30,A31
> From: bartenst
> Date: Thursday, January 02, 2003 03:07 PM
>
> Hi all!
>
> I am successfully running Gentoo Linux
> (http://www.gentoo.org) on my new A31. Unfortunately
> ACPI is not getting initialized properly with the new
> acpi-patch from 20021212 ( + vanilla 2.4.20). I consulted
> the acpi developers (http://acpi.sf.net) who told me that the
> problem is the buggy BIOS! Is IBM aware of that problem
> and are there any ongoing efforts to solve this problem?
>
> Thanks!
> Dom
>
> p.s.
> http://marc.theaimsgroup.com/?l=acpi4linux&m=103643408113691&w=2
> summary:
> "In short, ECDT -> EC_ID is supposed to be the full path
> name of your EC device in ACPI Namespace like
> "\_SB.PCI0.LPC.EC", but __NOT__ in your BIOS. You
> can work around your problem by adding hack code, but it
> makes OS
> code dirty to save broken BIOSes and it allows BIOS
> vendor not to fix their problem."
> ----------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
