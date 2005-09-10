From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: C states on AMD SMP
Date: Sat, 10 Sep 2005 10:59:25 +0200
Message-ID: <4322A06D.8050804@tzi.de>
References: <1126178956.24699.42.camel@localhost.localdomain>	 <43202621.9080600@tzi.de> <1126182374.4397.8.camel@localhost.localdomain>	 <43215F09.7030909@tzi.de> <1126339733.22979.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1126339733.22979.2.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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



Erik Slagter wrote:
> On Fri, 2005-09-09 at 12:08 +0200, Janosch Machowinski wrote:
> 
> 
>>The P_BLK is actually defined int the FADT...
>>And you do not have a _CST object, cause it would habe been decalared here :
>>     Scope (\_PR)
>>     {
>>         Processor (CPU0, 0x00, 0x00008010, 0x06) {}
>>         Processor (CPU1, 0x01, 0x00000000, 0x00) {}
>>     }
>>
>>
>>The little 0x06 after CPU0 tells us that there is an P_BLK,
>>but like pavel told us, I think the OEM of the Mainboard disabled C2 and 
>>  C3, but you are free to verify it ;-)
> 
> 
> Indeed:
> 
> Signature:        FACP
> Length:           244
> Revision:         0x01
> Checksum:         0xf7
> OEMID:            AMD
> OEM Table ID:     TECATE
> OEM Revision:     0x06040000
> Creator ID:       PTL
> Creator Revision: 0x000f4240
> FIRMWARE_CTRL:    0x3fefffc0
> DSDT:             0x3fefcf54
> INT_MODEL:        0x00
> SCI_INT:          9
> SMI_CMD:          0x0000802f
> ACPI_ENABLE:      0xf0
> ACPI_DISABLE:     0xf1
> S4BIOS_REQ:       0x00
> PM1a_EVT_BLK:     0x00008000
> PM1b_EVT_BLK:     0x00000000
> PM1a_CNT_BLK:     0x00008004
> PM1b_CNT_BLK:     0x00000000
> PM2_CNT_BLK:      0x00000000
> PM_TMR_BLK:       0x00008008
> GPE0_BLK:         0x00008020
> GPE1_BLK:         0x00000000
> PM1_EVT_LEN:      4
> PM1_CNT_LEN:      2
> PM2_CNT_LEN:      0
> PM_TM_LEN:        4
> GPE0_BLK_LEN:     4
> GPE1_BLK_LEN:     0
> GPE1_BASE:        0
> P_LVL2_LAT:       101
> P_LVL3_LAT:       1001
> FLUSH_SIZE:       0
> FLUSH_STRIDE:     0
> DUTY_OFFSET:      1
> DUTY_WIDTH:       0
> DAY_ALRM:         0x0d
> MON_ALRM:         0x00
> CENTURY:          0x32
> Flags:            0x00000005
> 
> Is there a way to patch the FADT or to fool linux-acpi into it does
> actually work (to at least be able to test the thing)?
Shure, patch the verify functions in processor_idle.c ...
But actually I think this is no good idea...
    Janosch


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
