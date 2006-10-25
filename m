From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Wed, 25 Oct 2006 23:18:59 +0800
Message-ID: <1C601A6A3344064EB423D0C1E83B717B5C5957@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21631 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1030474AbWJYPTF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 11:19:05 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>


>Obviously we can "fix" that in the short run by causing 
>"platform" to be the
>default.  Still, I think swsusp should work regardless of 
>whether "platform"
>or "shutdown" is used.

If a platform support ACPI, I guess, we'd better enable
platform S4 by default. Otherwise, sooner or later,
it will ran into some issues...

Thanks,
Luming
