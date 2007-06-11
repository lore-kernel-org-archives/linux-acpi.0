From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: clear gpe earily in resume?
Date: Mon, 11 Jun 2007 15:01:01 +0800
Message-ID: <FC1D1B23302A22499C60C967336B2AE00157D434@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1672 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbXFKHB1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jun 2007 03:01:27 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi,
If a GPE wakes up system from S3, a SCI interrupt is invoked, we haven't
a handler for such GPE. acpi_leave_sleep_state will disable/clear the
GPEs, but it is invoked with interrupt enabled and too late. I observed
a breakage in x60 and a lot of message 'No handler or method for GPE[
xxx]".
I thought we should do GPE clear at the end of 'acpi_pm_enter'. How do
you think?

Thanks,
Shaohua
