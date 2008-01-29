From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/5] ACPI: Add the T-state coordination
Date: Tue, 29 Jan 2008 11:18:00 -0500
Message-ID: <200801291118.00844.lenb@kernel.org>
References: <1201499422.17068.12.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48307 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932769AbYA2QUW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Jan 2008 11:20:22 -0500
In-Reply-To: <1201499422.17068.12.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

On Monday 28 January 2008 00:50, Zhao Yakui wrote:
> Hi, all,
> 
> This patch series is for T-state coordination.
> Patch 01 Set the bit of ACPI_PDC_SMP_T_SWCOORD.

shouldn't we be setting the PSD bit _last_ in this series
rather than first?

> Patch 02 Check the parameter when calling the function of
> acpi_processor_get/set_throttling. 
> Patch 03 Update the T-state coordination after obtaining _TSD info
> Patch 04 Add the t-state event notifier function
> Patch 05 Update the t-state for every affected cpu when t-state is
> changed 
> 
> I've tested this patch set on t61 laptop. It can work on the three
> T-state control mode(MSR, SystemIO, FADT).
> 
> 
> Thanks,
> Yakui
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
