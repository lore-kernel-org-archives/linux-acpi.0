From: marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
Subject: S4bios on Sony Vaio FX601
Date: Mon, 13 Jan 2003 10:40:03 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.50.0301130925480.3926-100000@flyby>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I have a Sony Vaio PCG-FX601 (FXA53 is the US model) and I wondering it
it support S4bios.
If it is supported, I need an A0 suspend partition?
FX601 model has same bios of FX60x, FX70x and perhaps FX80x models, is
there someone that has such notebooks that made S4bios to work?

I use kernel 2.4.20+APCI 20021205+swsusp16 but resuming after swsusp
my pc hangs almost the time.

If it can helps, pmtools say:

myhost:/tmp/pmtools-20010730# ./acpidmp/acpidmp FACP|./acpidmp/acpitbl
Signature:        FACP
Length:           116
Revision:         0x01
Checksum:         0x63
OEMID:            SONY
OEM Table ID:     K5
OEM Revision:     0x06040000
Creator ID:       PTL_
Creator Revision: 0x000f4240
FIRMWARE_CTRL:    0x0fefffc0
DSDT:             0x0fef9ac0
INT_MODEL:        0x00
SCI_INT:          9
SMI_CMD:          0x0000802f
ACPI_ENABLE:      0xf0
ACPI_DISABLE:     0xf1
S4BIOS_REQ:       0xf2
PM1a_EVT_BLK:     0x00008000
PM1b_EVT_BLK:     0x00000000
PM1a_CNT_BLK:     0x00008004
PM1b_CNT_BLK:     0x00000000
PM2_CNT_BLK:      0x00000000
PM_TMR_BLK:       0x00008008
GPE0_BLK:         0x00008020
GPE1_BLK:         0x00000000
PM1_EVT_LEN:      4
PM1_CNT_LEN:      2
PM2_CNT_LEN:      0
PM_TM_LEN:        4
GPE0_BLK_LEN:     4
GPE1_BLK_LEN:     0
GPE1_BASE:        0
P_LVL2_LAT:       90
P_LVL3_LAT:       1100
FLUSH_SIZE:       0
FLUSH_STRIDE:     0
DUTY_OFFSET:      0
DUTY_WIDTH:       4
DAY_ALRM:         0x7d
MON_ALRM:         0x7e
CENTURY:          0x32
Flags:            0x000001a5


myhost:/tmp/pmtools-20010730# ./acpidmp/acpidmp FACS|./acpidmp/acpitbl
Signature:              FACS
Length:                 64
Hardware Signature:     0x00000a59
Firmware Waking Vector: 0x00000000
Global Lock:            0x00000000
Flags:                  0x00000000


Thanks for any help.

--
Regards,  Marco Gigante


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
