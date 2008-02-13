From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] CPU_IDLE: Documentation for CPU_IDLE
Date: Tue, 12 Feb 2008 20:36:49 -0800
Message-ID: <47B273E1.70807@oracle.com>
References: <20080212015545.GA1691@linux-os.sc.intel.com> <20080212084605.28f0d3f3.randy.dunlap@oracle.com> <20080213011552.GA7319@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:34186 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbYBMEhW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Feb 2008 23:37:22 -0500
In-Reply-To: <20080213011552.GA7319@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Venki Pallipadi wrote:
> Updated reflecting Randy's comments.
> 
> Thanks,
> Venki
> 
> 
> Documentation for cpuidle infrastructure. This patch was submitted once
> a while back. But, somehow got dropped or never made it upstream.
> 
> Resending with updates.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Index: linux-2.6.25-rc/Documentation/cpuidle/core.txt
> ===================================================================
> --- /dev/null
> +++ linux-2.6.25-rc/Documentation/cpuidle/core.txt
> @@ -0,0 +1,24 @@
> +
> +		Supporting multiple CPU idle levels in kernel
> +
> +				cpuidle
> +
> +General Information:
> +
> +Various CPUs today support multiple idle levels that are differentiated
> +by varying exit latencies and power consumption during idle.
> +cpuidle is a generic in-kernel infrastructure that separates
> +idle policy (governor) from idle mechanism (driver) and provides a
> +standardized infrastructure to support independent development of
> +governors and drivers.
> +
> +cpuidle resides under drivers/cpuidle.
> +
> +Boot options:
> +"cpuidle_sysfs_switch"
> +enables current_governor interface in /sys/devices/system/cpu/cpuidle/.

s#cpuidle/.#cpuidle/,#

> +which can be used to switch governors at run time. This boot option
> +is meant for developer testing only. In normal usage, kernel picks the
> +best governor based on governor ratings.
> +SEE ALSO: sysfs.txt in this directory.

Thanks.
-- 
~Randy
