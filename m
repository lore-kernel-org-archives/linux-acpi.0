From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI: Add some debug statements related to PM
Date: Fri, 11 Aug 2017 01:30:50 +0200
Message-ID: <14884530.U9YM2D2TGn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51415 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751391AbdHJXlG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Aug 2017 19:41:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>

Hi,

The following two patches add pr_debug() and acpi_handle_debug() in a couple
of places to help debug issues related to ACPI events, such as device wakeup.

Thanks,
Rafael

