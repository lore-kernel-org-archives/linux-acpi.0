From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 0/3] Preparation for arranging hotplug memory in ZONE_MOVABLE.
Date: Wed, 14 Aug 2013 17:37:05 +0800
Message-ID: <1376473028-29380-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:24754 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759357Ab3HNJic (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Aug 2013 05:38:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, liwanp@linux.vnet.ibm.com, tj@kernel.org, zhangyanfei@cn.fujitsu.com, lenb@kernel.org, rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

These three trivial patches are from patch-set "Arrange hotpluggable memory as ZONE_MOVABLE."
And they have been acked and reviewed by many people.

Hope they can be merged first. And the rest patches are coming soon.


Tang Chen (3):
  acpi: Print Hot-Pluggable Field in SRAT.
  earlycpio.c: Fix the confusing comment of find_cpio_data().
  acpi: Kill macro INVALID_TABLE().

 arch/x86/mm/srat.c |   11 +++++++----
 drivers/acpi/osl.c |   36 ++++++++++++++++++++----------------
 lib/earlycpio.c    |   27 ++++++++++++++-------------
 3 files changed, 41 insertions(+), 33 deletions(-)

