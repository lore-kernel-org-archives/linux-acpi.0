From: "Xiao, Hui" <hui.xiao@linux.intel.com>
Subject: [RFC 0/1] ACPI, APEI, EINJ, Refine the fix of resource conflict
Date: Fri, 16 Sep 2011 02:03:33 -0700 (PDT)
Message-ID: <50782.10.238.130.145.1316163813.squirrel@linux.intel.com>
Reply-To: hui.xiao@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42100 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754941Ab1IPJDf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Sep 2011 05:03:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This patch is based on Ying's resource conflict fix patch:
        https://lkml.org/lkml/2011/8/30/51
which relies on valid user inputs and will not fully fix the conflict without
checking them.

This patch is trying to avoid such potential issues by param1 alignment check
and fetching exact conflict region from trigger action table entry.
