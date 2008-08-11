From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RESEND] [PATCH 2/4]  ACPI: Get the device power state in the
	course of scanning device
Date: Mon, 11 Aug 2008 15:02:20 +0800
Message-ID: <1218438140.6671.96.camel@yakui_zhao.sh.intel.com>
References: <1218437705.6671.84.camel@yakui_zhao.sh.intel.com>
	 <20080811064513.GJ9038@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15863 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbYHKGs1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 02:48:27 -0400
In-Reply-To: <20080811064513.GJ9038@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, 2008-08-11 at 08:45 +0200, Andi Kleen wrote:
> On Mon, Aug 11, 2008 at 02:55:05PM +0800, Zhao Yakui wrote:
> > Subject:ACPI: Get the device power state in the course of scanning device
> > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> > Get the device power state in the course of scanning device if the device 
> > power flag is power_managable. i.e. The device has the _PSx/_PRx object.
> > 
> > At the same time before the drivers/acpi/power module is loaded, there is no
> > relation between acpi_power_resource and acpi device. So the first parameter 
> > of acpi_power_get_state is changed to acpi_handle.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=8049
> > http://bugzilla.kernel.org/show_bug.cgi?id=11000
> 
> Seems to be an pretty old bug. I assume it's not critical
> enough to require pushing into .27? 
Yes. It is not critical. 
But in fact windows can work well on such broken BIOS. In order to make
Linux be compatible with this broken BIOS, it will be OK to merge them.

Thanks.
> 
> -Andi

