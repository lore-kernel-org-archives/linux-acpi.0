From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: ACPI, APEI/BERT support
Date: Thu,  7 May 2015 10:57:29 -0400
Message-ID: <1431010651-23117-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32261 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbbEGCDe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 May 2015 22:03:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[PATCH 1/2] ACPI, APEI, Boot Error Record Table (BERT) support
[PATCH 2/2] acpi, apei, bert: Clear error status at the end of error

ACPI/APEI is designed to verifiy/report H/W errors, like Corrected
Error(CE) and Uncorrected Error(UC). It contains four tables: HEST,
ERST, EINJ and BERT. The first three tables have been merged for
a long time, but because of lacking BIOS support for BERT, the
support for BERT is pending until now. Recently on ARM 64 platform
it is has been supported. So here we come.

The following log is a BERT record after system reboot because of
hitting a fatal error.

BERT: Obtained BERT iomem region <00000000fe801000-00000000fe802000> for BERT.
[Hardware Error]: Error record from previous boot:
[Hardware Error]: event severity: fatal
[Hardware Error]:  Error 0, type: fatal
[Hardware Error]:   section_type: memory error
[Hardware Error]:   physical_address: 0x00000000fe800000
[Hardware Error]:   physical_address_mask: 0x0000000000000fff
[Hardware Error]:   card: 0 module: 1 bank: 0 device: 1 row: 1 column: 1 bit_pos

