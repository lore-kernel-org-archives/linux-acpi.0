From: Len Brown <lenb@kernel.org>
Subject: [PATCH 00/11] SFI: Simple Firmware Interface - v3
Date: Fri, 14 Aug 2009 16:38:04 -0400
Message-ID: <1250282295-25216-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60942 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbZHNUki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 16:40:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Changes since v2:

 re-based to v2.6.31-rc6

 included here some patches from the ACPI tree
   that prepare for SFI

 deleted MMAP table parsing code
   It isn't needed in the kernel, since on all known SFI boxes today,
   the booter parses this table for us.

 fixed some build issues, generally related to CONFIG_ACPI=n

 various cosmetic changes in response to v2 code review

What is left to do:

 x86_32 can set CONFIG_PCI_MMCONFIG=y when
 SFI=y and ACPI=n, but x86_64 can not, yet.

 A number of drivers will use SFI and will provide
 their own table parsers, but those will come later.

thanks,
-Len

