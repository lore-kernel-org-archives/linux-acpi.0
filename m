From: Felipe Alfaro Solana <felipe_alfaro-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Re: 2.6.0-pre4 hangs if acpi enabled
Date: Tue, 26 Aug 2003 17:20:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1061911215.1647.2.camel@teapot.felipe-alfaro.com>
References: <20030825113313.GA10691@lps.ens.fr>
	 <1061813912.710.18.camel@teapot.felipe-alfaro.com>
	 <20030826143931.GA12993@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030826143931.GA12993-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?=C9ric?= Brunet <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-08-26 at 16:39, Éric Brunet wrote:

> By the way, why should people use APIC and IO-APIC on UP computers ? Is
> it faster or more efficient in some way ? Kernel documentation says that
> the APIC is a ``replacement for PC-style interrupt controller''. Is there
> anything the APIC can do that the traditionnal interupt controller can't
> do ? Kernel documentation is not very incentive for wasting an extra 7.5
> ko in the kernel image...

It seems that IO-APIC removes the 15 IRQ limit that is present when
using XT-PIC-style interrupt controllers. For example, on my P4 box with
IO-APIC enabled, IRQ9 is assigned exclusively to ACPI and is not shared
between multiple hardware devices. Also, USB UHCI is mapped to IRQ 23.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
