From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: SuSE AMD x86-64 bits installation issue
Date: 07 Nov 2003 05:57:15 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068202635.2682.972.camel@dhcppc4>
References: <6A7AB4426712514F9E2AB28C407285FA04EBB91B@exchtp02.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6A7AB4426712514F9E2AB28C407285FA04EBB91B-LbelAcagxFGsjcp6KUBrleoUnSXyNh8afZ5ll9d1lig@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: HurryLin-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, DreamKu-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, StephenChen-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, PearHuang-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, NormanChung-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, KenCho-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hurry,

I'm delighted to hear directly from VIA about these issues.

We've had difficulty in the past addressing VIA issues because detailed
information about VIA hardware is not publically published.  Having
access to a BIOS engineer who can actually change the BIOS to debug a
problem -- now _this_ is very exciting!

Agreed, customers will expect the IOAPIC to work -- the curret
workaround of running high performance systems in PIC mode is not
acceptable.

Re: the problem
I think what you're saying is that your _PRT uses PCI Link Devices in
APIC mode, and when you do the system hangs.  On the other hand, if the
_PRT returns static interrutps in APIC mode then the system works --
yes?

Not having a hardware diagram showing how this thing is wired up, I have
to ask why you don't simply use the static entries in APIC mode?

PCI Link Devices are actually quite rare in APIC mode.  They're more
often used in PIC mode to map all the PIRQs down onto the PIC pins.  So
Linux has not been heavily exercised in this configuration and we may
indeed have bugs there.

But on the other hand, programming a link device runs BIOS AML that
touches the hardware, and if that AML has bugs, or if the devices it
reads and writes to has bugs, then anything can happen.

Here's how you can help us work this issue.

1. send mail in plain text format if possible, or at least not html.
   I found your message in my Spam mailbox -- which is where
   all html messages go.  Others may have automatically delted it
   and not seen it at all.

2. I could not read the attachments to your message.
   Please file a bug and attach the supporting information to
   the bug report.

If the issue is specific to the SuSE kernel, then you want to file
it at http://bugzilla.suse.de  More likely this issue is not unique
to SuSE, and so you should file the bug against the baseline kernel(s).

How to file a bug against ACPI:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach the output from dmidecode, available in /usr/sbin/, or
here:
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.=
gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.

Please attach the output of lspci -v

thanks,
-Len Brown
Linux 2.4, Linux 2.6 ACPI maintainer


On Tue, 2003-11-04 at 04:34, HurryLin-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org wrote:
> Dear ACPI developers:
>=20
>         I am VIA bios engineer. We have APCI problem for SuSe.  We
> need your kindly support.=20
>=20
>         Now we meet a installation issue in APIC mode when we install
> SuSe 9.0 beta 3 on VIA platform. In ACPI part of BIOS, each interrupt
> pin (i.e. INTA, INTB, INTC, INTD ) of the device will get a assigned
> IRQ when we will claim device's IRQ routing on _PRT device
> configuration object. If interrupt pins of the device is dynamically
> decided IRQ through device object, then the system will hang during
> installation after _CRS control method is executed by OS on the
> refered device object and the current IRQ is returned. If we directly
> assign IRQ number to each interrupt pin of the device, the
> installation is OK. We think some problems on ACPI parsing duing
> installation.
>=20
>         We also find another problem about the behavior of different
> OS version. For SuSe 9.0 beta 3, the devices can operate in APIC mode
> (above IRQ 16) when we directly assign IRQ number to each interrupt
> pin of the device. The system will hang when interrupt pins of the
> device is dynamically decided IRQ through device object. For SuSe 9.0
> beta 6 and final version, the device always only operate in PIC mode.
> Customers can't accept our chipset that the IRQ routing of the devices
> is limited operated in PIC mode. We hope the IRQ routing results of
> the PCI devices to go back SuSe 9.0 beta 3 for future SuSe OS version.
> Let our platform operate in APIC mode. We have at least chance to
> operate in APIC mode for VIA chipset when interrupt pins of the device
> is directly assigned to IRQ number.=20
>=20
>         The "SuSE AMD x86-64 bits installation issue.txt" is more
> detailed descriptions about above problems and our analysis The
> "log.txt" is the log file gotten from the beta3 which we think the
> real problem existed in ACPI kernel.  If you have any questions please
> let me know. Thanks !
>=20
> <<SuSE AMD x86-64 bits installation issue.txt>>  <<log.txt>>=20
>         =20
>        =20
> Best Regards,
>=20
> =E6=9E=97=E7=9A=93=E7=90=B3            Hurry Hao-Lin Lin
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Software BIOS Team, System Platform, R & D Division, VIA Technologies,
> Inc.
> 8F, 533, Chung-Cheng Rd., Hsin-Tien,
> Taipei, Taiwan, R.O.C.
> Tel : 886-2-22185452 EXT. 7619
> Fax: 886-2-8667-1061
>=20
>=20



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
