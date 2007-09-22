From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Retain old acpi policy for !CONFIG_CPU_IDLE
Date: Fri, 21 Sep 2007 23:00:55 -0400
Message-ID: <200709212300.56116.lenb@kernel.org>
References: <20070913204005.GB1183@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47393 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055AbXIVDBQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Sep 2007 23:01:16 -0400
In-Reply-To: <20070913204005.GB1183@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org, abelay@novell.com

I couldn't get this patch to apply.

the current cpuidle branch is rooted at 2.6.22.
I'd like to see a patch on top of that branch
that restores as much of processor_idle.c as possible
to the state in 2.6.22.

ie. a diff of 2.6.22 and cpuidle processor_idle.c
should be as small as possible -- and it is okay
to use a bunch of CONFIG_CPU_IDLE ifdefs to keep things simple.

I can take care of merging that with the other changes
to processor_idle.c that have come along in 2.6.23.

thanks,
-Len


On Thursday 13 September 2007 16:40, Venki Pallipadi wrote:
> 
> Retain the old policy in processor_idle, so that when CPU_IDLE is not
> configured, old C-state policy will still be used. This provides a
> clean gradual migration path from old acpi policy to new cpuidle
> based policy.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Index: linux-2.6.23-rc6/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-2.6.23-rc6.orig/drivers/acpi/processor_idle.c
> +++ linux-2.6.23-rc6/drivers/acpi/processor_idle.c
> @@ -65,14 +65,20 @@ ACPI_MODULE_NAME("processor_idle");
