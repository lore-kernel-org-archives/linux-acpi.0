From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.6.25-rc3] cpuidle: fix cpuidle time and usage overflow
Date: Mon, 25 Feb 2008 11:15:33 +0100
Message-ID: <20080225101533.GB30685@elte.hu>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com> <1201043126.3861.5.camel@yangyi-dev.bj.intel.com> <1203032921.3897.10.camel@yangyi-dev.bj.intel.com> <1203900372.4954.8.camel@yangyi-dev.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:57473 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583AbYBYKQU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 05:16:20 -0500
Content-Disposition: inline
In-Reply-To: <1203900372.4954.8.camel@yangyi-dev.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yi Yang <yi.y.yang@intel.com>
Cc: akpm@linux-foundation.org, venkatesh.pallipadi@intel.com, cpufreq@lists.linux.org.uk, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


* Yi Yang <yi.y.yang@intel.com> wrote:

> cpuidle C-state sysfs node time and usage are very easy to overflow 
> because they are all of unsigned int type, time will overflow within 
> about two hours, usage will take longer time to overflow, but they are 
> increasing for ever.
> 
> This patch will convert them to unsigned long long.

what happens if such an overflow happens - any particular regression or 
other misbehavior, or just funny looking stats in sysfs?

	Ingo
