From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: linux 2.5.67, no suspend state
Date: Sat, 19 Apr 2003 10:06:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030419080605.GA20694@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello,

I have a shuttle xpc sb51G (intel chipset) with redhat 9 + kernel 2.5.67
with a patch to drivers/net/8139too.c to help S3 working (the patch was
found on this list. It consists in one call to refrigerator and two calls
to pci_set_p=F4wer_state.)

When I try to go S1, it looks like the computer goes into sleep state and
wakes up immediately. Here is an extract of the logs:

[...]
=3Dzsh entered refrigerator
=3Dsu entered refrigerator
=3Danacron entered refrigerator
=3D|
Suspending devices
Suspending device c03730cc
Suspending devices
Suspending device c03730cc
suspending: hda <0>Suspending devices
uhci-hcd 00:1d.0: suspend to state 1
uhci-hcd 00:1d.1: suspend to state 1
uhci-hcd 00:1d.2: suspend to state 1
ehci-hcd 00:1d.7: suspend to state 1
Suspending device c03730cc
 hwsleep-0257 [18] acpi_enter_sleep_state: Entering sleep state [S1]
Back to C!
Devices Resumed
   evgpe-0396: *** Error: acpi_ev_gpe_dispatch: No handler or method for
GPE[ 0], disabling event
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
ehci-hcd 00:1d.7: resume
uhci-hcd 00:1d.2: resume
PCI: Setting latency timer of device 00:1d.2 to 64
uhci-hcd 00:1d.1: resume
PCI: Setting latency timer of device 00:1d.1 to 64
uhci-hcd 00:1d.0: resume
PCI: Setting latency timer of device 00:1d.0 to 64
Devices Resumed
Restarting tasks... done
init left refrigerator
[...]

I have no idea what is this device c03730cc.

With S3 sleeping state, things are more complicated. It worked sometimes
with the 2.5.63+acpi patch kernel I was using, but, most of the times,
the computer hung at suspend time at various places. I have not yet
managed to have it working with the current kernel. I will do some tests
and make a real bug report. But is it worth reporting S3 not working when
even S1 does not work ?

=C9ric Brunet


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
