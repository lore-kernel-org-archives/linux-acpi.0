From: Guenther Thomsen <tho-NfGIfjByo2U0TNoGDjcNAsJftPPqhGjr@public.gmane.org>
Subject: Re: ACPI prevents detection of SCSI HA
Date: Fri, 15 Nov 2002 09:01:58 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E18Cjqw-0004e8-00@doma.ballum>
References: <3DD4EC39.7080703@optonline.net>
Reply-To: Guenther Thomsen <gthomsen-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Fri, 15 Nov 2002 07:44:41 EST."
             <3DD4EC39.7080703-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bernd Pfrommer <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message <3DD4EC39.7080703-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, Bernd Pfrommer writes:
> 
> --Boundary_(ID_CUXpniOZ81rtoskgeL4PIQ)
> Content-type: text/plain; charset=us-ascii; format=flowed
> Content-transfer-encoding: 7BIT
> 
> This looks exactly like the problem I have with my AMIBIOS on an Intel 
> SRMK2 dual PIII server.
> Andy suggested patching a bug in the DSDT by swapping the contents of 
> the If and Else in the snippet below:
> 
>     Method(GETI, 1) {
>         If(And(Arg0, 0xf, )) {
>             Return(Zero)
>         }
>         Else {
>             Return(\MLIB.CNV2(And(Arg0, 0xf, )))
>         }
>     }
> 
> 
> Then the interrupt assignment looks more reasonable, but there is still 
> a problem with the IRQ distribution such that the SCSI disk cannot be 
> accessed. So as of right now, my box won't boot either unless I set 
> acpi=off.
> 
> Is your system a dual-PIII (max 1GHz) with a ServerWorks chipset?
> 
> Bernd
>
I haven't tried the patch yet, but yes the motherboard is an (early
version I guess, as the 53c1010 is a 33MHz version, not 66MHz as 
documented in the manual) ASUS CUR-DSL: ServerWorks OSB4 chipset,
Symbios Logic 53c1010 Utra 3 SCSI two channel HA, dual Pentium III 
(up to 1GHz I believe) capable, but only one 933MHz CPU installed.

h.t.h.
	Guenther


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
