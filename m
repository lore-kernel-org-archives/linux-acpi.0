From: matteo <surya-06ZeP6ie+xM@public.gmane.org>
Subject: acpi problem notebook shutdown
Date: Fri, 13 Feb 2004 11:44:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402CAAA1.2010003@email.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi all
this is the problem:

i've an ASUS L3Tp notebook with debian sid that work right with
2.6.0-test9 (!!!)
i've tried to upgrade the kernel but all that time my lapotop's fan
start very fast and the notebook shutdown.

this is the error that i can view on log files:
- --------------------
Feb  2 19:55:20 shanti kernel:     ACPI-0297: *** Error:
AE_AML_PACKAGE_LIMIT while evaluating method [_L02] for GPE[ 0]
Feb  2 19:55:20 shanti kernel:     ACPI-1120: *** Error: Method
execution failed [\_TZ_.RSCM] (Node ddf372e0), AE_AML_PACKAGE_LIMIT
Feb  2 19:55:20 shanti kernel:     ACPI-1120: *** Error: Method
execution failed [\_GPE._L02] (Node ddf377a0), AE_AML_PACKAGE_LIMIT
Feb  2 19:55:20 shanti kernel:     ACPI-0297: *** Error:
AE_AML_PACKAGE_LIMIT while evaluating method [_L02] for GPE[ 0]
Feb  2 19:55:20 shanti kernel:     ACPI-1120: *** Error: Method
execution failed [\_TZ_.RSCM] (Node ddf372e0), AE_AML_PACKAGE_LIMIT
Feb  2 19:55:20 shanti kernel:     ACPI-1120: *** Error: Method
execution failed [\_GPE._L02] (Node ddf377a0), AE_AML_PACKAGE_LIMIT
Feb  2 19:55:20 shanti kernel:     ACPI-0297: *** Error:
AE_AML_PACKAGE_LIMIT while evaluating method [_L02] for GPE[ 0]
Feb  2 19:55:20 shanti kernel:     ACPI-1120: *** Error: Method
execution failed [\_TZ_.RSCM] (Node ddf372e0), AE_AML_PACKAGE_LIMIT
Feb  2 19:55:20 shanti kernel:     ACPI-1120: *** Error: Method
execution failed [\_GPE._L02] (Node ddf377a0), AE_AML_PACKAGE_LIMIT
Feb  2 19:55:20 shanti kernel:     ACPI-0297: *** Error:
AE_AML_PACKAGE_LIMIT while evaluating method [_L02] for GPE[ 0]
[...]
- --------------------
in loop until the laptop shutdown...

this is my lspci
- --------------------
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual
PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 10)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem]
(rev a0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
00:0a.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
SiS650/651/M650/740 PCI/AGP VGA Display Adapter
- --------------------
i've tried to append acpi=off but the problem is the same,
i've changed the kernel configuration without acpi, but the problem is
the same, i've changed also the kernel configuration with apm but there
isn't nothing to do...

someone can help me?

i've tried also with apm but the problem is the same

thanks

Matteo

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFALKqeTiN+fo8lHEgRAlxmAJ4go0pEQlhumQ2pD7PD/OnjVgWTJQCfSxH6
sHNqEUyCx8gl2pKZyzpr7Uw=
=ZzVP
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
