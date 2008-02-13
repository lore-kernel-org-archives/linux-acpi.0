From: Mike Travis <travis@sgi.com>
Subject: Re: [PATCH 2/4] acpi: change cpufreq tables to per_cpu variables
Date: Wed, 13 Feb 2008 10:10:00 -0800
Message-ID: <47B33278.3060408@sgi.com>
References: <20080208233738.108449000@polaris-admin.engr.sgi.com>	<20080208233738.427702000@polaris-admin.engr.sgi.com> <20080212153356.d2be3248.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:45395 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750861AbYBMSKF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 13:10:05 -0500
In-Reply-To: <20080212153356.d2be3248.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mingo@elte.hu, tglx@linutronix.de, ak@suse.de, clameter@sgi.com, steiner@sgi.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

Andrew Morton wrote:
> On Fri, 08 Feb 2008 15:37:40 -0800
> Mike Travis <travis@sgi.com> wrote:
> 
>> Change cpufreq tables from arrays to per_cpu variables in
>> drivers/acpi/processor_thermal.c
>>
>> Based on linux-2.6.git + x86.git
> 
> I fixed a bunch of rejects in "[PATCH 1/4] cpufreq: change cpu freq tables
> to per_cpu variables" and it compiles OK.  But this one was beyond my
> should-i-repair-it threshold, sorry.

Should I rebase all the pending patches on 2.6.25-rc1 or 2.6.24-mm1
(or some other combination)?

Thanks,
Mike
