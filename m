From: Shaohua Li <shaohua.li@intel.com>
Subject: [BUG] nvidia vga card is missed after S3
Date: Fri, 28 Mar 2008 16:00:29 +0800
Message-ID: <1206691229.1362.5.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30700 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbYC1ICy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2008 04:02:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Still in ASUS A6VC laptop (linux is quite broken in the system). If
'pm_restore_console()' is called the video card (03:00.0, Nevidia Go
6200/6400, it hasn't a driver) pci config space read is messy (some are
0xffffffff, others are 0). If I comment pm_restore_console(), then
everything is fine. Anything I can provide to debug the issue?

Thanks,
Shaohua

