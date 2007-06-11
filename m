From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: clear gpe earily in resume?
Date: Mon, 11 Jun 2007 09:17:31 +0200
Message-ID: <200706110917.31705.rjw@sisk.pl>
References: <FC1D1B23302A22499C60C967336B2AE00157D434@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37067 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbXFKHLT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jun 2007 03:11:19 -0400
In-Reply-To: <FC1D1B23302A22499C60C967336B2AE00157D434@pdsmsx411.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi@vger.kernel.org

Hi,

On Monday, 11 June 2007 09:01, Li, Shaohua wrote:
> Hi,
> If a GPE wakes up system from S3, a SCI interrupt is invoked, we haven't
> a handler for such GPE. acpi_leave_sleep_state will disable/clear the
> GPEs, but it is invoked with interrupt enabled and too late. I observed
> a breakage in x60 and a lot of message 'No handler or method for GPE[
> xxx]".
> I thought we should do GPE clear at the end of 'acpi_pm_enter'. How do
> you think?

I think that the GPEs should be disabled in acpi_pm_enter(), but the runtime
GPEs shouldn't be enabled before _WAK is executed.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
