From: matt mercer <fl0yd-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
Subject: FADT question
Date: Fri, 16 May 2003 11:34:32 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EC50508.4060909@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I think I found a bug in my FADT. Could someone eye this for sanity 
please. It sure looks wrong to me... Any suggestions for fix would be 
appreciated.


We see PM2_CNT_BLK as 0x803e. However according to my datasheet, I show 
this register at 0x8030.  See the data below.

ACPI IO Registers: (ranged by 0x8000)
--------------------------------------
01h-00h		PM1_STS
03h-02h		PM1_EN
05h-04h		PM1_CTL
07h-06h		reserved
0Bh-08h		PM1_TMR
0Fh-0Ch		reserved
13h-10h		P_CNTRL
14h     	P_LVL2
15h     	P_LVL3
17h-16h 	reserved
1Fh-18h 	GPE_STS0
27h-20h 	GPE_EN0
2Bh-28h 	reserved
2Ch     	GPE_CTL
2Eh-2Dh 	reserved
2Fh     	GT_CTL
30h     	PM2_CTL
3Bh-31h 	reserved
3Fh-3Ch 	AC_CTL


FADT dump:
---------------------------------------
Signature:        FACP
Length:           116
Revision:         0x01
Checksum:         0x52
OEMID:            TMETA
OEM Table ID:     PDB.ALI
OEM Revision:     0x06040003
Creator ID:       PTL
Creator Revision: 0x000f4240
FIRMWARE_CTRL:    0x06ffffc0
DSDT:             0x06ffcbf4
INT_MODEL:        0x00
SCI_INT:          9
SMI_CMD:          0x000000b1
ACPI_ENABLE:      0xf0
ACPI_DISABLE:     0xf1
S4BIOS_REQ:       0xf2
PM1a_EVT_BLK:     0x00008000
PM1b_EVT_BLK:     0x00000000
PM1a_CNT_BLK:     0x00008004
PM1b_CNT_BLK:     0x00000000
PM2_CNT_BLK:      0x0000803e
PM_TMR_BLK:       0x00008008
GPE0_BLK:         0x00008018
GPE1_BLK:         0x00000000
PM1_EVT_LEN:      4
PM1_CNT_LEN:      2
PM2_CNT_LEN:      1
PM_TM_LEN:        4
GPE0_BLK_LEN:     16
GPE1_BLK_LEN:     0
GPE1_BASE:        0
P_LVL2_LAT:       15
P_LVL3_LAT:       82
FLUSH_SIZE:       0
FLUSH_STRIDE:     0
DUTY_OFFSET:      1
DUTY_WIDTH:       3
DAY_ALRM:         0x0d
MON_ALRM:         0x00
CENTURY:          0x32
Flags:            0x00000125


Thanks in advance,
Matt



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
