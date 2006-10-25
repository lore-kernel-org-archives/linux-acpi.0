From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Wed, 25 Oct 2006 18:42:28 +0400
Message-ID: <453F77D4.2080706@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:2582 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750818AbWJYOmg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 10:42:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>

Hi,

There is a problem with swsuspend and GPE events.
Now they are restored from acpi_pm_finish(), which is called only if we
suspend with "platform" option, what means that if we suspended to disk
with the default "shutdown" option after resume all the GPEs will be disabled.
This presents us with the overheating problem after resume at very least.
I see two solutions: one is to make "platform" to be default option if ACPI is enabled,
and second -- enable GPE events from some other function, which will be called in any case.

What do you think?

Regards,
	Alex.
