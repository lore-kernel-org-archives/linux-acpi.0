From: Chris Lawrence <cnlawren-otVW4P3Rl+RCuWAPc0MYQg@public.gmane.org>
Subject: Re: Toshiba Dynabook S7 ACPI problems
Date: 22 Jul 2003 22:06:18 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1058925977.1255.7.camel@satellite>
References: <m2wuem8g1i.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2wuem8g1i.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2003-07-13 at 13:58, Jan Rychter wrote:
> 4. I don't know if this is ACPI's fault, but it seems all devices want to
> sit on the same IRQ:
> 
>   ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
>   ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
>   ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
>   ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11)
>   ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11)
>   ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11)
>   ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11)
>   ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11)

This is common on systems that are (mostly) legacy-free like my Toshiba
laptop; the ACPI IRQ balancing code tries to avoid putting PCI
interrupts on lines that legacy ISA devices use.  If you modify
drivers/acpi/pci_link.c (look for the "penalty" table) you can make the
IRQ allocation saner (there probably ought to be a kernel argument to
adjust the penalty table, or at least something that will de-penalize
legacy system IRQs).


Chris
-- 
Chris Lawrence <cnlawren-otVW4P3Rl+RCuWAPc0MYQg@public.gmane.org>
Department of Physics and Astronomy, University of Mississippi


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
