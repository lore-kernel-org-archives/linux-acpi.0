From: Alex Chiang <achiang@hp.com>
Subject: [PATCH v4 0/6] ACPI: dock: code hygiene
Date: Mon, 19 Oct 2009 15:14:19 -0600
Message-ID: <20091019211132.5412.80438.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:29061 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206AbZJSVUq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Oct 2009 17:20:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =shaohua.li@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This is v4 of a modest attempt to clean up the dock driver.

As before, compile tested only, since I don't have any machines
that provide _DCK.

Thanks.
/ac

v3 -> v4:
	- defensively code in case sysfs_create_group() fails and
	  sysfs_remove_group() can't handle removing a non-existent group;
	  suggested by Dmitry Torokhov

v2 -> v3:
	- now using an attribute_group, as suggested by Dmitry Torokhov

v1 -> v2:
	- changed how we add platform device data, based on Shaohua Li's
  	  review
---

Alex Chiang (6):
      ACPI: dock: convert sysfs attributes to an attribute_group
      ACPI: dock: combine add|alloc_dock_dependent_device
      ACPI: dock: remove global 'dock_device_name'
      ACPI: dock: dock_add - hoist up platform_device_register_simple()
      ACPI: dock: add struct dock_station * directly to platform device data
      ACPI: dock: minor whitespace and style cleanups


 drivers/acpi/dock.c |  266 ++++++++++++++++++---------------------------------
 1 files changed, 93 insertions(+), 173 deletions(-)

