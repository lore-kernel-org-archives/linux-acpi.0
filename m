From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RESEND] [PATCH 2/4]  ACPI: Get the device power state in the course of scanning device
Date: Mon, 11 Aug 2008 08:52:45 +0200
Message-ID: <20080811065245.GK9038@one.firstfloor.org>
References: <1218437705.6671.84.camel@yakui_zhao.sh.intel.com> <20080811064513.GJ9038@one.firstfloor.org> <1218438140.6671.96.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:43800 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbYHKGvm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Aug 2008 02:51:42 -0400
Content-Disposition: inline
In-Reply-To: <1218438140.6671.96.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, Aug 11, 2008 at 03:02:20PM +0800, Zhao Yakui wrote:
> On Mon, 2008-08-11 at 08:45 +0200, Andi Kleen wrote:
> > On Mon, Aug 11, 2008 at 02:55:05PM +0800, Zhao Yakui wrote:
> > > Subject:ACPI: Get the device power state in the course of scanning device
> > > From: Zhao Yakui <yakui.zhao@intel.com>
> > > 
> > > Get the device power state in the course of scanning device if the device 
> > > power flag is power_managable. i.e. The device has the _PSx/_PRx object.
> > > 
> > > At the same time before the drivers/acpi/power module is loaded, there is no
> > > relation between acpi_power_resource and acpi device. So the first parameter 
> > > of acpi_power_get_state is changed to acpi_handle.
> > > 
> > > http://bugzilla.kernel.org/show_bug.cgi?id=8049
> > > http://bugzilla.kernel.org/show_bug.cgi?id=11000
> > 
> > Seems to be an pretty old bug. I assume it's not critical
> > enough to require pushing into .27? 
> Yes. It is not critical. 
> But in fact windows can work well on such broken BIOS. In order to make

Any guess how do they do that? Do they have a blacklist for this case?

> Linux be compatible with this broken BIOS, it will be OK to merge them.

The option is fine since it is off by default, but I'm a little scaried 
about the init sequence ordering for .27. That might break something.

-Andi
