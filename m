From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: two minor update patches for RAS
Date: Mon, 28 Jul 2014 02:50:58 -0400
Message-ID: <1406530260-26078-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39244 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbaG1HWR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jul 2014 03:22:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, n-horiguchi@ah.jp.nec.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org

[PATCH 1/2] APEI, GHES: Cleanup unnecessary function for lock-less
[PATCH 2/2] RAS, HWPOISON: Fix wrong error recovery status

These two patches are trivial fixes for APEI and HWPOISON.
Send them together to avoid fragments.
