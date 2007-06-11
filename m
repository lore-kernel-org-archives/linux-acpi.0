From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: clear gpe earily in resume?
Date: Mon, 11 Jun 2007 15:14:23 +0800
Message-ID: <1181546063.4328.1.camel@sli10-conroe.sh.intel.com>
References: <FC1D1B23302A22499C60C967336B2AE00157D434@pdsmsx411.ccr.corp.intel.com>
	 <200706110917.31705.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28196 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbXFKHSs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jun 2007 03:18:48 -0400
In-Reply-To: <200706110917.31705.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Mon, 2007-06-11 at 09:17 +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 11 June 2007 09:01, Li, Shaohua wrote:
> > Hi,
> > If a GPE wakes up system from S3, a SCI interrupt is invoked, we haven't
> > a handler for such GPE. acpi_leave_sleep_state will disable/clear the
> > GPEs, but it is invoked with interrupt enabled and too late. I observed
> > a breakage in x60 and a lot of message 'No handler or method for GPE[
> > xxx]".
> > I thought we should do GPE clear at the end of 'acpi_pm_enter'. How do
> > you think?
> 
> I think that the GPEs should be disabled in acpi_pm_enter(), but the runtime
> GPEs shouldn't be enabled before _WAK is executed.
Not sure about runtime GPEs, properly current implementation is ok.
Wakeup GPE should be clear/disable in acpi_pm_enter, I think.

Thanks,
Shaohua
