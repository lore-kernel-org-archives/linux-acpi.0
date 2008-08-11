From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RESEND] [PATCH 2/4]  ACPI: Get the device power state in the
	course of scanning device
Date: Mon, 11 Aug 2008 18:21:15 +0800
Message-ID: <1218450075.6671.135.camel@yakui_zhao.sh.intel.com>
References: <1218437705.6671.84.camel@yakui_zhao.sh.intel.com>
	 <20080811064513.GJ9038@one.firstfloor.org>
	 <1218438140.6671.96.camel@yakui_zhao.sh.intel.com>
	 <20080811065245.GK9038@one.firstfloor.org>
	 <1218441074.6671.113.camel@yakui_zhao.sh.intel.com>
	 <20080811075611.GL9038@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60887 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbYHKKH0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 06:07:26 -0400
In-Reply-To: <20080811075611.GL9038@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, 2008-08-11 at 09:56 +0200, Andi Kleen wrote:
> > After the patch is applied, Linux will still do the power state check
> > unless the boot option of "acpi.power_nocheck=1" is added.  In such case
> > it won't affect anything. 
> 
> Understood that.
> 
> > In fact we expect that the boot option of "acpi.power_nocheck=1" becomes
> > the default. But we will have to wait for more response. Only after more
> > tests are done, it will be OK.
> 
> Ok. 
> 
> > what the init sequence ordering for .27 means? 
> 
> The first patch moved acpi_device_set_context to be earlier, so 
> the init sequence is different. All the other changes are optional,
> as in conditional on the flag, but that one is not.
Although the acpi_device_set_context is moved to the earlier in the
first patch, it won't break anything.  In the patch the acpi device is
bound with the acpi handle before getting the flag of Power
management/Wakeup/Performance.
Maybe it can be put to the acpi test tree to test whether it will break
anything.
Thanks.

> I have not been completely able to satisfy myself that it is low 
> risk enough.
> 
> -Andi

