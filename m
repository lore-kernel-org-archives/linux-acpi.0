From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 0/5] ACPI: Add the T-state coordination
Date: Wed, 30 Jan 2008 08:46:11 +0800
Message-ID: <1201653971.8808.7.camel@yakui_zhao.sh.intel.com>
References: <1201499422.17068.12.camel@yakui_zhao.sh.intel.com>
	 <200801291118.00844.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56445 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbYA3BD7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Jan 2008 20:03:59 -0500
In-Reply-To: <200801291118.00844.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tue, 2008-01-29 at 11:18 -0500, Len Brown wrote:
> On Monday 28 January 2008 00:50, Zhao Yakui wrote:
> > Hi, all,
> > 
> > This patch series is for T-state coordination.
> > Patch 01 Set the bit of ACPI_PDC_SMP_T_SWCOORD.
> 
> shouldn't we be setting the PSD bit _last_ in this series
> rather than first?
> 
Thanks. 
Both are OK. Maybe it is more appropriate to put it in the first because
it tells that the T_SWCOORD bit is related to T-state coordination.
> > Patch 02 Check the parameter when calling the function of
> > acpi_processor_get/set_throttling. 
> > Patch 03 Update the T-state coordination after obtaining _TSD info
> > Patch 04 Add the t-state event notifier function
> > Patch 05 Update the t-state for every affected cpu when t-state is
> > changed 
> > 
> > I've tested this patch set on t61 laptop. It can work on the three
> > T-state control mode(MSR, SystemIO, FADT).
> > 
> > 
> > Thanks,
> > Yakui
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 

