From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: IBM Thinkpad A31 | ACPI problems
Date: Fri, 3 Jan 2003 02:29:42 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000301c2b284$8a15d8f0$232202d3@sayonara>
References: <200301011555.06058.dom@wahuu.at>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200301011555.06058.dom-K271P2BsTd0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: dom-K271P2BsTd0@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I browsed the mailing list archives (December 2002, November 2002) and

> encountered several postings from Sandro (PSI-Systems
<psi-systems-8XqT/MH+8ao@public.gmane.org>) 
> who is having the same problem with his Thinkpad A31 laptop: 
> ACPI: Found ECDT
> ACPI: Could not use ECDT
> evxfevnt-0119 [06] Acpi_disable          : ACPI mode disabled
> 
> ACPI is completely disabled for IBM Thinkpad A31. Is there a 
> solution for that 
> problem available? How can I be of any help to the ACPI developers?
> 

Did you also read Andy Grover's reply to Sandro? 

Subject:  RE: [ACPI] ACPI does not work since
acpi-20021022-2.4.20-pre11.di
From:     "Grover, Andrew" <andrew.grover () intel ! com>
Date:     2002-11-04 18:19:30
http://marc.theaimsgroup.com/?l=acpi4linux&m=103643408113691&w=2

In short, ECDT -> EC_ID is supposed to be the full path name of your EC
device in ACPI Namespace like "\_SB.PCI0.LPC.EC", but __NOT__ in your
BIOS. 
You can work around your problem by adding hack code, but it makes OS
code dirty to save broken BIOSes and it allows BIOS vendor not to fix
their problem.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
