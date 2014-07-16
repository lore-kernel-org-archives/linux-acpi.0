From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Some RAS bug fix patches
Date: Tue, 15 Jul 2014 22:34:39 -0400
Message-ID: <1405478082-30757-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17481 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760645AbaGPDFK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2014 23:05:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

[PATCH 1/3] APEI, GHES: Cleanup unnecessary function for lock-less
[RFC PATCH 2/3] x86, MCE: Avoid potential deadlock in MCE context
[PATCH 3/3] RAS, HWPOISON: Fix wrong error recovery status

The patch 1/3 & 3/3 are minor fixes which are irrelevant with patch
2/3. I send them together just to avoid fragments.

The patch 2/3 is a RFC patch depending on the following thread:
https://lkml.org/lkml/2014/6/27/26

Comments and suggestions are welcome.
