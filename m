From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/3] ACPI / button: Clarify initial lid state
Date: Fri, 27 May 2016 15:15:43 +0800
Message-ID: <cover.1464332745.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:56463 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215AbcE0HPv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 May 2016 03:15:51 -0400
In-Reply-To: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The initial _LID returning value is not reliable after boot/resume because
the BIOS vendors may implement it by returning a cached value that is only
updated when a lid notification is received.
This causes strange things happening after resuming. This patchset fixes
the issue according to this fact.

Lv Zheng (3):
  ACPI / button: Remove initial lid state notification
  ACPI / button: Refactor functions to eliminate redundant code
  ACPI / button: Send "open" state after boot/resume

 drivers/acpi/button.c |   96 ++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 44 deletions(-)

-- 
1.7.10

