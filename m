From: Carl Thompson <cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org>
Subject: C2 or C3 on Presario 2110US?
Date: Wed,  5 Mar 2003 05:34:29 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046871269.3bf3b7b878989@carlthompson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
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
To: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Hello,

     I just upgraded my laptop to a Compaq Presario 2110US and am
pleased to report for the most part Linux ACPI works excellently on it
(without the problems I have on my Sony Vaios).  The one exception is
that Linux ACPI does not have any processor support for it (everything
in /proc/acpi/processor/CPU0 reads "<not supported>" except power which
tells me that only the C1 state is available.  I believe the problem is
that the chipset used in the laptop is reasonably new (ATI/ALI combo),
in particular the ATI bridges.  Is there any effort to get ACPI working
on this chipset?  In particular I would like to see C2 or C3 because the
2110 has the loudest fan I've heard on a laptop.  I am willing to help
in any way I can and here is the output of lspci:

00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
00:01.0 PCI bridge: ATI Technologies Inc U1/A3 AGP Bridge [IGP 320M]
(rev 01)
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem]
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:12.0 Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1

The processor itself is a Mobile AMD Athlon 2000+.

Thanks,
Carl Thompson




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
