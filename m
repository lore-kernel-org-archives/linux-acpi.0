From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Samsung P35
Date: Fri, 12 Nov 2004 18:44:54 +0100
Message-ID: <20041112174454.GJ31422@poupinou.org>
References: <41948E80.5030207@helios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41948E80.5030207-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> 
> Here is the result:
> ---snip---
> or: Method execution failed [\_SB_.PCI0.LPCB.PS2M._STA] (Node dff273e0), 
> AE_AML_REGION_LIMIT
>     ACPI-0154: *** Error: Method execution failed 
> [\_SB_.PCI0.LPCB.PS2M._STA] (Node dff273e0), AE_AML_REGION_LIMIT
>     ACPI-1133: *** Error: Method execution failed 
> [\_SB_.PCI0.IDEC.SECD.S_D0._STA] (Node dff27a40), AE_AML_NO_RETURN_VALUE
>     ACPI-0154: *** Error: Method execution failed 
> [\_SB_.PCI0.IDEC.SECD.S_D0._STA] (Node dff27a40), AE_AML_NO_RETURN_VALUE
>     ACPI-1133: *** Error: Method execution failed 
> [\_SB_.PCI0.IDEC.SECD.S_D1._STA] (Node dff279a0), AE_AML_NO_RETURN_VALUE
>     ACPI-0154: *** Error: Method execution failed 
> [\_SB_.PCI0.IDEC.SECD.S_D1._STA] (Node dff279a0), AE_AML_NO_RETURN_VALUE
> ...

Sound like current iasl is broken.  Could you please post the
DSDT.aml obtained privately to me?

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
