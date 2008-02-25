From: Yi Yang <yi.y.yang@intel.com>
Subject: Re: [PATCH 2.6.25-rc3] cpuidle: fix cpuidle time and usage overflow
Date: Mon, 25 Feb 2008 09:10:26 +0800
Message-ID: <1203901826.4954.11.camel@yangyi-dev.bj.intel.com>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
	 <1201043126.3861.5.camel@yangyi-dev.bj.intel.com>
	 <1203032921.3897.10.camel@yangyi-dev.bj.intel.com>
	 <1203900372.4954.8.camel@yangyi-dev.bj.intel.com>
	 <20080225101533.GB30685@elte.hu>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43159 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbYBYK0H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 05:26:07 -0500
In-Reply-To: <20080225101533.GB30685@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@linux-foundation.org, venkatesh.pallipadi@intel.com, cpufreq@lists.linux.org.uk, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 2008-02-25 at 11:15 +0100, Ingo Molnar wrote:
> * Yi Yang <yi.y.yang@intel.com> wrote:
> 
> > cpuidle C-state sysfs node time and usage are very easy to overflow 
> > because they are all of unsigned int type, time will overflow within 
> > about two hours, usage will take longer time to overflow, but they are 
> > increasing for ever.
> > 
> > This patch will convert them to unsigned long long.
> 
> what happens if such an overflow happens - any particular regression or 
> other misbehavior, or just funny looking stats in sysfs?
They are just stats info in sysfs, cpuidle's behaviors don't depend on
them. I didn't notice any regression or misbehaviors.

> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

