Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D50C433E9
	for <linux-acpi@archiver.kernel.org>; Thu, 14 Jan 2021 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F21223B19
	for <linux-acpi@archiver.kernel.org>; Thu, 14 Jan 2021 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbhANSsp (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:48:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52470 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbhANSsp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2021 13:48:45 -0500
Received: from 89-64-81-33.dynamic.chello.pl (89.64.81.33) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 5835532344c3e18a; Thu, 14 Jan 2021 19:48:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans De Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] ACPI: scan: Adjust white space in acpi_device_add()
Date:   Thu, 14 Jan 2021 19:47:37 +0100
Message-ID: <8659794.ROA1lt5W1e@kreacher>
In-Reply-To: <3494203.VBaj39JGmp@kreacher>
References: <3494203.VBaj39JGmp@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add empty lines in some places in acpi_device_add() to help
readability and drop leading spaces before the labels in there.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -692,10 +692,12 @@ int acpi_device_add(struct acpi_device *
 
 	if (device->wakeup.flags.valid)
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
+
 	mutex_unlock(&acpi_device_lock);
 
 	if (device->parent)
 		device->dev.parent = &device->parent->dev;
+
 	device->dev.bus = &acpi_bus_type;
 	device->dev.release = release;
 	result = device_add(&device->dev);
@@ -711,16 +713,19 @@ int acpi_device_add(struct acpi_device *
 
 	return 0;
 
- err:
+err:
 	mutex_lock(&acpi_device_lock);
+
 	if (device->parent)
 		list_del(&device->node);
+
 	list_del(&device->wakeup_list);
 
- err_unlock:
+err_unlock:
 	mutex_unlock(&acpi_device_lock);
 
 	acpi_detach_data(device->handle, acpi_scan_drop_device);
+
 	return result;
 }
 



