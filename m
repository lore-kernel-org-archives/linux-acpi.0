From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: C states on AMD SMP
Date: Thu, 8 Sep 2005 13:52:06 +0200
Message-ID: <20050908115205.GA3795@tangens.sinus.cz>
References: <1126178956.24699.42.camel@localhost.localdomain>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1126178956.24699.42.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Hi,
> 
> I compiled & installed 2.6.13 (vanilla) on my Tyan Tiger S2466 (AMD768
> chipset, 2xathlon MP 2600) yesterday. Indeed, as expected, acpi
> "/proc/acpi/processor/*/power" (C states) is now supported on SMP. But,
> to my surprise, it only shows one C state (C1), which, I assume, is
> full-on. I am not completely sure about the CPU, but I do know that at
> least the chipset supports C2 and C3 states (even got it sort of working
> with pm_amd76x).
> 
> Can someone shine some light on this?
> 
> active state:            C1
> max_cstate:              C8
> bus master activity:     00000000
> states:
>    *C1:                  type[C1] promotion[--] demotion[--] latency[000] usage[59379522]
> 
Hi!
  I have MSI K7D Master with the same chipset and the same problem :-).
  Try to dump Your FADT. Mine is as follows:

# cat /proc/acpi/fadt | acpitbl
Signature:        FACP
Length:           244
Revision:         0x01
Checksum:         0x5f
OEMID:            AMD2P
OEM Table ID:     AWRDACPI
OEM Revision:     0x42302e31
Creator ID:       AWRD
Creator Revision: 0x00000000
FIRMWARE_CTRL:    0x1fff0000
DSDT:             0x1fff30c0
INT_MODEL:        0x01
SCI_INT:          9
SMI_CMD:          0x0000062f
ACPI_ENABLE:      0xa1
ACPI_DISABLE:     0xa0
S4BIOS_REQ:       0x00
PM1a_EVT_BLK:     0x00000600
PM1b_EVT_BLK:     0x00000000
PM1a_CNT_BLK:     0x00000604
PM1b_CNT_BLK:     0x00000000
PM2_CNT_BLK:      0x00000000
PM_TMR_BLK:       0x00000608
GPE0_BLK:         0x00000620
GPE1_BLK:         0x00000000
PM1_EVT_LEN:      4
PM1_CNT_LEN:      2
PM2_CNT_LEN:      0
PM_TM_LEN:        4
GPE0_BLK_LEN:     4
GPE1_BLK_LEN:     0
GPE1_BASE:        0
P_LVL2_LAT:       101
P_LVL3_LAT:       1001
FLUSH_SIZE:       0
FLUSH_STRIDE:     0
DUTY_OFFSET:      1
DUTY_WIDTH:       1
DAY_ALRM:         0x7d
MON_ALRM:         0x7e
CENTURY:          0x7f
Flags:            0x00000000

Do You see ? P_LVL2_LAT is 101 and P_LVL3_LAT is 1001, exactly 1 ms ABOVE the
maximum stated in the ACPI spec as allowed. Somebody at Tyan (or MSI in my
case) decided to disable generic C2/C3 support. Maybe because the chipset 
requires more care to handle the C2/C3 states than described in the ACPI spec.

I'm using pm_amd76x regularly too, and it works perfectly!
                                           Regards, Pavel Troller


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
