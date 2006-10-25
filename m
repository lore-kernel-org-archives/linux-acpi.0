From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Wed, 25 Oct 2006 23:15:41 +0800
Message-ID: <1C601A6A3344064EB423D0C1E83B717B5C5954@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7196 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1030469AbWJYPPw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 11:15:52 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>

>
>There is a problem with swsuspend and GPE events.
>Now they are restored from acpi_pm_finish(), which is called only if we
>suspend with "platform" option, what means that if we suspended to disk
>with the default "shutdown" option after resume all the GPEs 
>will be disabled.
>This presents us with the overheating problem after resume at 
>very least.
>I see two solutions: one is to make "platform" to be default 
>option if ACPI is enabled,
>and second -- enable GPE events from some other function, 
>which will be called in any case.
>
>What do you think?
>

I prefer platform S4 as default...

--Luming
