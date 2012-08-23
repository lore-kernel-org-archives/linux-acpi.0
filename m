From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] lpc_ich: Fix a 3.5 kernel regression for iTCO_wdt
 driver
Date: Thu, 23 Aug 2012 13:08:14 +0800
Message-ID: <20120823130814.6ba359e9@feng-i7>
References: <1344959772-23018-1-git-send-email-feng.tang@intel.com>
	<20120822195512.GI27604@spo001.leaseweb.com>
	<20120822215543.GA1954@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29134 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab2HWFOb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Aug 2012 01:14:31 -0400
In-Reply-To: <20120822215543.GA1954@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Aaron Sierra <asierra@xes-inc.com>, Bob Moore <robert.moore@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, rui.zhang@intel.com

On Wed, 22 Aug 2012 22:55:43 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Wed, Aug 22, 2012 at 09:55:12PM +0200, Wim Van Sebroeck wrote:
> 
> > Any idea why the acpi_check_resource_conflict() check gives a conflict?
> 
> Because the resource range is declared in ACPI and we assume that that 
> means the firmware wants to scribble on it. We'd need the output of 
> acpidump to work out whether that's safe or not.

Good point, I checked the conflict for iTCO_wdt, the conflict exists on
almost all the machines I have.

According to ICH (7/8/9 etc)spec, the TCO watchdog has a 32 bytes long IO 
space resource, and the bit 9 of TCO1_STS register is "DMISCI_STS", which
 indicates whether a SCI happens, and will be cleared by writing 1
to it. Most of DSDT table will claim a TCO op region only for one bit:
"DMISCI_STS" , as some method may need to access that bit. 

I think there is some risk, but it's quite safe as the DMISCI_STS bit has
nothing to do with TCO driver itself, and TCO driver never access it, also
this TCO driver has been there for years, and this resource conflict also
exists for many generations hardware. 

Thanks,
Feng



