From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: redhat comment about intel not taking patches?
Date: Wed, 12 Feb 2003 13:24:21 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A175@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Kevin Fenzi <kevin-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Kevin Fenzi [mailto:kevin-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org] 
> RedHat is playing with enabling ACPI in their next release. (At least
> in the beta for the next release: phoebe). 
> 
> Noticed this changelog comment in the phoebe kernel: 
> 
> * Thu Nov 07 2002 Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> - - remove ACPI again because Intel is unwilling to take patches
> 
> What patches are they talking about? 
> 
> Is there any way we could fix up the communication breakdown between
> RedHat/Intel?
> 
> It would be great if ACPI would work out of the box on my laptop with
> a RedHat kernel. At a minimum I guess it would require acpi to be able
> to detect the compaq *PNP stuff and remove the * so the table works. 

I have been in contact with a number of distributions concerning
inclusion of ACPI support. I think the new licensing and some recent
source improvements helped a lot to make people feel better about ACPI,
but there still are a number of critical bugs that are affecting a
significant percentage of systems. These need to be fixed. These have to
do with *any* ACPI-related oopses, failure to boot using ACPI, and
failure to shutdown cleanly.

ACPI is not going to be in the next RH release but we are really pushing
to get it in subsequent releases, but we need to fix those critical
bugs.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
