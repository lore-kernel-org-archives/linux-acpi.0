From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: Static check result
Date: Fri, 25 Dec 2015 05:07:09 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB0C17F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33202 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbbLYFHT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Dec 2015 00:07:19 -0500
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "Dan Carpenter (dan.carpenter@oracle.com)" <dan.carpenter@oracle.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Rafael

Dan has reported several issues related in acpi_dbg.c.
They were caught by the static checkers.
And the fixes are here:
https://patchwork.kernel.org/patch/7915401/
https://patchwork.kernel.org/patch/7915441/
https://patchwork.kernel.org/patch/7915461/
https://patchwork.kernel.org/patch/7920421/
Hope you can take a look when you have time.
Thanks in advance.

Best regards
-Lv
