From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFD][PATCH 2/7] PM / QoS: Introduce request and constraint data
 types for PM QoS flags
Date: Sat, 29 Sep 2012 14:02:41 +0800
Message-ID: <50668F01.7030406@intel.com>
References: <201209282351.10663.rjw@sisk.pl> <201209282352.49615.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25508 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754951Ab2I2GCo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Sep 2012 02:02:44 -0400
In-Reply-To: <201209282352.49615.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Huang Ying <ying.huang@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Jean Pihet <j-pihet@ti.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mark gross <markgross@thegnar.org>

On 2012/9/29 5:52, Rafael J. Wysocki wrote:
> Index: linux/kernel/power/qos.c
> ===================================================================
> --- linux.orig/kernel/power/qos.c
> +++ linux/kernel/power/qos.c
> @@ -213,6 +213,69 @@ int pm_qos_update_target(struct pm_qos_c
>   }
>
>   /**
> + * pm_qos_flags_remove_req - Remove device PM QoS flags request.
> + * @f: Device PM QoS flags set to remove the request from.
-------^
A typo     	
> + * @req: Request to remove from the set.
> + */


-- 
Best Regards
Tianyu Lan
linux kernel enabling team
