From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] CPU_IDLE: Documentation for CPU_IDLE
Date: Tue, 12 Feb 2008 08:46:05 -0800
Message-ID: <20080212084605.28f0d3f3.randy.dunlap@oracle.com>
References: <20080212015545.GA1691@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:64760 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763650AbYBLQrA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Feb 2008 11:47:00 -0500
In-Reply-To: <20080212015545.GA1691@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Mon, 11 Feb 2008 17:55:45 -0800 Venki Pallipadi wrote:

> 
> Documentation for cpuidle infrastructure. This patch was submitted once
> a while back. But, somehow got dropped or never made it upstream.
> 
> Resending with updates.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

> Index: linux-2.6.25-rc/Documentation/cpuidle/sysfs.txt
> ===================================================================
> --- /dev/null
> +++ linux-2.6.25-rc/Documentation/cpuidle/sysfs.txt
> @@ -0,0 +1,81 @@
> +
> +
> +		Supporting multiple CPU idle levels in kernel
> +
> +				cpuidle sysfs
> +
> +System global cpuidle related information and tunables are under
> +/sys/devices/system/cpu/cpuidle
> +
> +The current interfaces in this directory has self-explanatory names:
> +* current_driver
> +* current_governor_ro
> +
> +With cpuidle_sysfs_switch boot option (meant for developer testing)

Is 'cpuidle_sysfs_switch' usage documented anywhere?


> +following objects are visible instead.
> +* current_driver
> +* available_governors
> +* current_governor
> +In this case user can switch the governor at run time by writing

                users [or "a user"]

> +onto current_governor.

s/onto/to/ [?]

> +
> +
> +Per logical CPU specific cpuidle information are under
> +/sys/devices/system/cpu/cpuX/cpuidle
> +for each online cpu X
> +
...
> +
> +
> Index: linux-2.6.25-rc/Documentation/cpuidle/governor.txt
> ===================================================================
> --- /dev/null
> +++ linux-2.6.25-rc/Documentation/cpuidle/governor.txt
> @@ -0,0 +1,30 @@
> +
> +
> +
> +		Supporting multiple CPU idle levels in kernel
> +
> +				cpuidle governors
> +
> +
> +
> +
> +cpuidle governor is policy routine that decides what idle state to enter at
> +any given time. cpuidle core uses different callbacks to the governor.
> +
> +* enable() to enable governor for a particular device
> +* disable() to disable governor for a particular device
> +* select() to select an idle state to enter
> +* reflect() called after returning from the idle state, which can be used
> +  by the governor for some record keeping.
> +
> +More than one governor can be registered at the same time and
> +user can switch between drivers using /sysfs interface (when enabled).

   users [or "a user"]

> +More than one governor part is supported for developers to easily experiment
> +with different governors. By default, most optimal governor based on your
> +kernel configuration and platform will be selected by cpuidle.
> +
> +Interfaces:
> +extern int cpuidle_register_governor(struct cpuidle_governor *gov);
> +extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
> +struct cpuidle_governor

Thanks.
---
~Randy
