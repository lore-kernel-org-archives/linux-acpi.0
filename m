From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [patch 3/3] drivers/idle/intel_idle.c: remove redundant local_irq_disable()
 call
Date: Wed, 11 Jan 2012 21:29:44 +0530
Message-ID: <4F0DB1F0.1060408@linux.vnet.ibm.com>
References: <20120110234821.E8BF5100270@wpzn3.hot.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:57896 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732Ab2AKP75 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2012 10:59:57 -0500
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 11 Jan 2012 21:29:54 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q0BFxoqb4386862
	for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2012 21:29:51 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q0BFxnE6027813
	for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2012 21:29:50 +0530
In-Reply-To: <20120110234821.E8BF5100270@wpzn3.hot.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org, yanmin_zhang@linux.intel.com, mingmingx.zhang@intel.com, shaohua.li@intel.com

On 01/11/2012 05:18 AM, akpm@linux-foundation.org wrote:

> From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
> Subject: drivers/idle/intel_idle.c: remove redundant local_irq_disable() call
> 
> irq disabling happens earlier in process_32.c:cpu_idle.  Basically,
> cpuidle_state->enter is called, cpu irq is disabled.  cpuidle_state->enter
> would turn on irq when exiting.
> 
> intel_idle doesn't follow this assumption.  Although it doesn't cause real
> issue, it misleads developers.  Remove the call to local_irq_disable() at
> entry.
> 
> [akpm@linux-foundation.org: add comment]
> Signed-off-by: mzha38X <mingmingx.zhang@intel.com>

                 ^^^^^^^
Are nicknames acceptable? AFAIK, real names are preferred...

> Cc: "Li, Shaohua" <shaohua.li@intel.com>
> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 


Regards,
Srivatsa S. Bhat
IBM Linux Technology Center

