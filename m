From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Invalid PBLK length
Date: Wed, 18 Dec 2002 17:00:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021218160003.GA4257@poup.poupinou.org>
References: <200212181536.gBIFabD09402@ikffws2.ikff.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200212181536.gBIFabD09402-sBhUd1W9t4xfrO0PeCDDO4ECbGbo6+O1OOFObY0sJ7w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Cc: ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 18, 2002 at 04:36:36PM +0100, Jens Haug wrote:

> > Note that it is FACS (the signature of the table), not FADT (I don't know
> > why the sig. and the name of this table are not the same).
> 
> But this FACS doesn't give me much information (since it's only
> the signature, I guess).
> It sais:
> 
> Signature:		FACS
> Length:			64
> Hardware Signature:	0x00000000
> Firmware Waking Vector: 0x00000000
> Global Lock:		0x00000000
> Flags:			0x00000000
> 

Ouch!  Sorry.  FACP is the signature of FADT in fact.
FACS is the sig. of the FACS table, which contains the global lock and
other things.

./acpidmp FACP | ./acpitbl

Should give something like:

Signature:        FACP
Length:           116
Revision:         0x01
Checksum:         0x48
OEMID:            TOSCPL
OEM Table ID:     888M1
OEM Revision:     0x06040001
Creator ID:       PTL
Creator Revision: 0x00000001
FIRMWARE_CTRL:    0x0fefffc0
DSDT:             0x0fefa060
INT_MODEL:        0x00
SCI_INT:          9
SMI_CMD:          0x000000b2
ACPI_ENABLE:      0xf0
ACPI_DISABLE:     0xf1
S4BIOS_REQ:       0xf2
PM1a_EVT_BLK:     0x00001000
PM1b_EVT_BLK:     0x00000000
PM1a_CNT_BLK:     0x00001004
PM1b_CNT_BLK:     0x00000000
PM2_CNT_BLK:      0x00001020
PM_TMR_BLK:       0x00001008
GPE0_BLK:         0x00001028
GPE1_BLK:         0x0000102c
PM1_EVT_LEN:      4
PM1_CNT_LEN:      2
PM2_CNT_LEN:      1
PM_TM_LEN:        4
GPE0_BLK_LEN:     4
GPE1_BLK_LEN:     4
GPE1_BASE:        16
P_LVL2_LAT:       10
P_LVL3_LAT:       1001
FLUSH_SIZE:       0
FLUSH_STRIDE:     0
DUTY_OFFSET:      1
DUTY_WIDTH:       3
DAY_ALRM:         0x0d
MON_ALRM:         0x08
CENTURY:          0x32
Flags:            0x00000025


You can, as an alternative, give something like that:

cat /proc/acpi/fadt | ./acpitbl 


Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
