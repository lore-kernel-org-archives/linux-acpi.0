From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 0/9] ACPI, APEI patches for 2.6.37
Date: Mon, 25 Oct 2010 15:43:21 +0800
Message-ID: <1287992610-14996-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:45374 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305Ab0JYHng (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 03:43:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, ying.huang@intel.com, linux-acpi@vger.kernel.org

v2:

- Some minor changes according to Andi's comments.


[PATCH -v2 1/9] ACPI, APEI, Add ERST record ID cache
[PATCH -v2 2/9] Add lock-less version of bitmap_set/clear
[PATCH -v2 3/9] lock-less NULL terminated single list implementation
[PATCH -v2 4/9] lock-less general memory allocator
[PATCH -v2 5/9] Hardware error device core
[PATCH -v2 6/9] Hardware error record persistent support
[PATCH -v2 7/9] ACPI, APEI, Use ERST for hardware error persisting before panic
[PATCH -v2 8/9] ACPI, APEI, Report GHES error record with hardware error device core
[PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error Source POLL/IRQ/NMI notification type support
