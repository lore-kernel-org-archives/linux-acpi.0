From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RESEND] [PATCH 2/4]  ACPI: Get the device power state in the course of scanning device
Date: Mon, 11 Aug 2008 09:56:11 +0200
Message-ID: <20080811075611.GL9038@one.firstfloor.org>
References: <1218437705.6671.84.camel@yakui_zhao.sh.intel.com> <20080811064513.GJ9038@one.firstfloor.org> <1218438140.6671.96.camel@yakui_zhao.sh.intel.com> <20080811065245.GK9038@one.firstfloor.org> <1218441074.6671.113.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:57304 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbYHKHzI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Aug 2008 03:55:08 -0400
Content-Disposition: inline
In-Reply-To: <1218441074.6671.113.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, lenb@kernel.org

> After the patch is applied, Linux will still do the power state check
> unless the boot option of "acpi.power_nocheck=1" is added.  In such case
> it won't affect anything. 

Understood that.

> In fact we expect that the boot option of "acpi.power_nocheck=1" becomes
> the default. But we will have to wait for more response. Only after more
> tests are done, it will be OK.

Ok. 

> what the init sequence ordering for .27 means? 

The first patch moved acpi_device_set_context to be earlier, so 
the init sequence is different. All the other changes are optional,
as in conditional on the flag, but that one is not.

I have not been completely able to satisfy myself that it is low 
risk enough.

-Andi
