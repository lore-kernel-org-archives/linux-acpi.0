From: <joerg.beyer-htSm2yLGOjU@public.gmane.org>
Subject: problem dumping/fixing dsdt
Date: Sun, 22 Sep 2002 12:29:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209221029.g8MATCX10556@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpilist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I tried to fix my dsdt, but it _think_, that acpidump
does not handle my table well. I get a very short table,
as you can see below. Since I dont have experience with
stuff like this, I would like to ask, if the below
results are expected.

    yours
    Joerg


wally:/usr/src/pacpidump/pacpidump # ./acpidump >dsdt.asl
acpidump: DSDT is corrupt

wally:/usr/src/pacpidump/pacpidump # cat dstdt.asl
/*
RSD PTR: Checksum=173, OEMID=PTLTD, RsdtAddress=0x0effbfc0
 */
/*
RSDT: Length=40, Revision=1, Checksum=135,
    OEMID=PTLTD, OEM Table ID=  RSDT, OEM Revision=0x6040000,
    Creator ID= LTP, Creator Revision=0x0
 */
/*
    Entries={ 0x0efffb8c }
 */
/*
    DSDT=0xeffbfe8
    INT_MODEL=PIC
    SCI_INT=9
    SMI_CMD=0x802f, ACPI_ENABLE=0xf0, ACPI_DISABLE=0xf1, S4BIOS_REQ=0xf2
    PM1a_EVT_BLK=0x8000-0x8003
    PM1a_CNT_BLK=0x8004-0x8005
    PM2_TMR_BLK=0x8008-0x800b
    PM2_GPE0_BLK=0x8020-0x8023
    P_LVL2_LAT=90ms, P_LVL3_LAT=1900ms
    FLUSH_SIZE=0, FLUSH_STRIDE=0
    DUTY_OFFSET=0, DUTY_WIDTH=4
    DAY_ALRM=125, MON_ALRM=126, CENTURY=50
    Flags={WBINVD,PROC_C1,SLP_BUTTON,RTC_S4}
 */
wally:/usr/src/pacpidump/pacpidump # iasl -tc dsdt.asl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20020829 [Aug 29 2002]
Copyright (C) 2000 - 2002 Intel Corporation
Supports ACPI Specification Revision 2.0a

dsdt.asl    27:
Error    1037 -^ parse error, expecting `error' or `PARSEOP_DEFINITIONBLOCK'

ASL Input:  dsdt.asl - 27 lines, 652 bytes, 0 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
