From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [patch 2/2] x86: Manage ENERGY_PERF_BIAS based on cpufreq
 governor
Date: Wed, 03 Mar 2010 09:55:38 -0800
Message-ID: <1267638938.16916.957.camel@localhost.localdomain>
References: <20100303000649.757684000@intel.com>
	 <20100303000849.278509000@intel.com> <20100303164007.GA31365@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:58104 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755406Ab0CCRzk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Mar 2010 12:55:40 -0500
In-Reply-To: <20100303164007.GA31365@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Dave Jones <davej@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2010-03-03 at 08:40 -0800, Matthew Garrett wrote:
> Have you done any measurements with this bit being set dynamically by 
> ondemand depending on the target frequency?
> 

The not so good part about this feature is that its setting is opaque.
Different CPUs can use this value for different optimizations. So, in
future we may have to change the value of this MSR based on frequency or
other metrics. But, for CPUs which support this MSR today, changing the
value with frequency do not make any difference.

Thanks,
Venki

