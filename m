From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: [PATCH 0/2] acpi,memory-hotplug : remove memory device by acpi_bus_remove()
Date: Thu, 4 Oct 2012 10:44:21 +0900
Message-ID: <506CE9F5.8020809@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42570 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab2JDBor (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Oct 2012 21:44:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: len.brown@intel.com, wency@cn.fujitsu.com

The patch-set was divided from following thread's patch-set.

https://lkml.org/lkml/2012/9/5/201

If you want to know the reason, please read following thread.

https://lkml.org/lkml/2012/10/2/83

The patch exports "acpi_bus_remove()" for removing a acpi device from a
acpi bus at memory hot plug.


