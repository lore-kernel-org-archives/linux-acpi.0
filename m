From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] ACPI: simplify hotplug profile kobject work
Date: Wed, 25 Sep 2013 14:22:56 -0600
Message-ID: <20130925202037.18667.31220.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ye0-f180.google.com ([209.85.213.180]:56710 "EHLO
	mail-ye0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab3IYU2i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2013 16:28:38 -0400
Received: by mail-ye0-f180.google.com with SMTP id m15so90277yen.11
        for <linux-acpi@vger.kernel.org>; Wed, 25 Sep 2013 13:28:37 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

These are pretty trivial and don't fix any problems; they just
simplify the kobject setup a bit.

---

Bjorn Helgaas (3):
      ACPI / hotplug: Set kobject name via kobject_add(), not kobject_set_name()
      ACPI / hotplug: Don't set kobject parent pointer explicitly
      ACPI / hotplug: Use kobject_init_and_add() instead of _init() and _add()


 drivers/acpi/sysfs.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)
