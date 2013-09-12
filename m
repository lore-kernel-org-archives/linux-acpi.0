From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [Bug report] Warning when hot-add an ACPI0004 device.
Date: Thu, 12 Sep 2013 13:00:57 +0800
Message-ID: <52314A89.2060809@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:31366 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab3ILE6e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Sep 2013 00:58:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Toshi Kani <toshi.kani@hp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Rafael, Toshi,

When we hot-add an ACPI0004 device, we got the following warning:

	acpi ACPI0004:01: Attempt to re-insert

The ACPI0004 device is a System Board in Fujitsu server, which has two
numa nodes (processors and memory).

It seems that we reserved the ACPI_NOTIFY_DEVICE_CHECK event twice in
acpi_hotplug_notify_cb().


According to bisect, this happens after the following commit:

 From 68a67f6c78b80525d9b3c6672e7782de95e56a83 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Sun, 3 Mar 2013 23:05:55 +0100
Subject: [PATCH 1/1] ACPI / container: Use common hotplug code

Switch the ACPI container driver to using common device hotplug code
introduced previously.  This reduces the driver down to a trivial
definition and registration of a struct acpi_scan_handler object.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Toshi Kani <toshi.kani@hp.com>
Tested-by: Toshi Kani <toshi.kani@hp.com>
---
  drivers/acpi/container.c | 146 
++++-------------------------------------------
  1 file changed, 10 insertions(+), 136 deletions(-)


I'm now investigating this problem. If you have any idea about why this
happens, please let me know.

Thanks. :)

