From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: Bug 16210 -  BUG: scheduling while atomic:
	swapper/0/0x10000002 when ACPI is initialised
Date: Thu, 01 Jul 2010 16:45:57 +0800
Message-ID: <1277973957.4144.14.camel@minggr.sh.intel.com>
References: <1277973846.4144.11.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11033 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab0GAIpN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 04:45:13 -0400
In-Reply-To: <1277973846.4144.11.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: francois.valenduc@tvcablenet.be
Cc: astarikovskiy@suse.de, fengguang.wu@intel.com, dfeng@redhat.com, "Moore, Robert" <robert.moore@intel.com>, rui.zhang@intel.com, linux-acpi@vger.kernel.org

(CC linux-acpi list)

On Thu, 2010-07-01 at 16:44 +0800, Lin Ming wrote:
> Hi,
> 
> Alexy, Fengguang, Xiaotian,
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=16210
> 
> This bug is about the ACPICA preemption point, would you guys please
> have a look at it?
> 
> /* Used within ACPICA to show where it is safe to preempt execution */
> #include <linux/hardirq.h>
> #define ACPI_PREEMPTION_POINT() \
>         do { \
>                 if (!in_atomic_preempt_off() && !irqs_disabled()) \
>                         cond_resched(); \
>         } while (0)
> 
> Thanks,
> Lin Ming

