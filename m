From: Len Brown <len.brown@intel.com>
Subject: Re: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Fri, 27 Oct 2006 01:22:34 -0400
Message-ID: <200610270122.34846.len.brown@intel.com>
References: <453F77D4.2080706@linux.intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:29408 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1423683AbWJ0FUB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Oct 2006 01:20:01 -0400
In-Reply-To: <453F77D4.2080706@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>

On Wednesday 25 October 2006 10:42, Alexey Starikovskiy wrote:
> Hi,
> 
> There is a problem with swsuspend and GPE events.
> Now they are restored from acpi_pm_finish(), which is called only if we
> suspend with "platform" option, what means that if we suspended to disk
> with the default "shutdown" option after resume all the GPEs will be disabled.
> This presents us with the overheating problem after resume at very least.

> I see two solutions: one is to make "platform" to be default option if ACPI is enabled,
> and second -- enable GPE events from some other function, which will be called in any case.

We need to do both.

"platform" needs to be the default on ACPI-enabled platforms because
when "shutdown" is used, wakeup devices that function from S4
but fail to function from S5 are unavailable.

Further, if somebody chooses to use "shutdown", certainly GPEs
need to work when they resume.

-Len
