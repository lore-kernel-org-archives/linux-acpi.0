From: Orion Poplawski <orion@cora.nwra.com>
Subject: ACPI Log messages level
Date: Mon, 29 Sep 2014 11:59:14 -0600
Message-ID: <54299DF2.2070709@cora.nwra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mercury.cora.nwra.com ([4.28.99.165]:36349 "EHLO
	mail.cora.nwra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbaI2SFd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Sep 2014 14:05:33 -0400
Received: from [10.10.20.7] (barry.cora.nwra.com [10.10.20.7])
	(authenticated bits=0)
	by mail.cora.nwra.com (8.14.4/8.14.4) with ESMTP id s8THxEBs010690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2014 11:59:15 -0600
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm trying to just look at just "warning" level messages and above with
"journalctl --priority 0..4", but am seeing the following which appear to be
informational only:

Sep 29 11:10:24 barry kernel: ACPI: RSDP 0x00000000000FEC30 000024 (v02 DELL  )
Sep 29 11:10:24 barry kernel: ACPI: XSDT 0x00000000000FCCC7 000074 (v01 DELL
 B10K     00000015
Sep 29 11:10:24 barry kernel: ACPI: FACP 0x00000000000FCDB7 0000F4 (v03 DELL
 B10K     00000015
Sep 29 11:10:24 barry kernel: ACPI: DSDT 0x00000000FFE9E952 004A74 (v01 DELL
 dt_ex    00001000
Sep 29 11:10:24 barry kernel: ACPI: FACS 0x00000000DFDF9C00 000040
Sep 29 11:10:24 barry kernel: ACPI: SSDT 0x00000000FFEA33C6 000089 (v01 DELL
 st_ex    00001000
Sep 29 11:10:24 barry kernel: ACPI: APIC 0x00000000000FCEAB 00015E (v01 DELL
 B10K     00000015
Sep 29 11:10:24 barry kernel: ACPI: BOOT 0x00000000000FD009 000028 (v01 DELL
 B10K     00000015
Sep 29 11:10:24 barry kernel: ACPI: ASF! 0x00000000000FD031 000096 (v32 DELL
 B10K     00000015
Sep 29 11:10:24 barry kernel: ACPI: MCFG 0x00000000000FD0C7 00003C (v01 DELL
 B10K     00000015
Sep 29 11:10:24 barry kernel: ACPI: HPET 0x00000000000FD103 000038 (v01 DELL
 B10K     00000015
Sep 29 11:10:24 barry kernel: ACPI: TCPA 0x00000000000FD35F 000032 (v01 DELL
 B10K     00000015
Sep 29 11:10:24 barry kernel: ACPI: DMAR 0x00000000000FD391 0000B8 (v01 DELL
 B10K     00000015
Sep 29 11:10:24 barry kernel: ACPI: SSDT 0x00000000DFE4DC00 002454 (v01 INTEL
 PPM RCM  80000001
Sep 29 11:10:24 barry kernel:   DMA      [mem 0x00001000-0x00ffffff]
Sep 29 11:10:24 barry kernel:   DMA32    [mem 0x01000000-0xffffffff]
Sep 29 11:10:24 barry kernel:   Normal   [mem 0x100000000-0x61fffffff]
Sep 29 11:10:24 barry kernel: ACPI: All ACPI Tables successfully acquired
Sep 29 11:10:24 barry kernel: ACPI: Enabled 3 GPEs in block 00 to 3F

I see this:
./drivers/acpi/acpica/tbxfload.c:
        ACPI_INFO((AE_INFO, "All ACPI Tables successfully acquired"));

which would appear to be sending the message with INFO priority, so I don't
understand why this is appearing here.  This is with kernel
3.16.3-200.fc20.x86_64.

-- 
Orion Poplawski
Technical Manager                     303-415-9701 x222
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                   http://www.nwra.com
