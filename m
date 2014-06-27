From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 4/9] ACPI, x86: Extended error log driver for x86
 platform
Date: Fri, 27 Jun 2014 11:22:27 +0200
Message-ID: <20140627092227.GA23153@pd.tnic>
References: <1382084624-10857-1-git-send-email-gong.chen@linux.intel.com>
 <1382084624-10857-5-git-send-email-gong.chen@linux.intel.com>
 <52612BA4.2060906@linux.vnet.ibm.com>
 <53AD0275.7020003@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56291 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbaF0JWe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jun 2014 05:22:34 -0400
Content-Disposition: inline
In-Reply-To: <53AD0275.7020003@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xie XiuQi <xiexiuqi@huawei.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, joe@perches.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Li Bin <huawei.libin@huawei.com>

On Fri, Jun 27, 2014 at 01:34:45PM +0800, Xie XiuQi wrote:
> The call graph is like this,
> do_machine_check
>  -> mce_log
>   -> atomic_notifier_call_chain(&x86_mce_decoder_chain ...)
>    -> ...
>     -> extlog_print
>      -> print_extlog_rcd
>       -> __print_extlog_rcd
>        -> printk
> 
> There's a logbuf_lock in printk. If logbuf_lock is held by other cpu,
> it'll lead to an infinity spin here. Isn't it?

Yes, but we want to take the risk and print something out before the
machine dies instead of waiting to get into printk-safe context first
and maybe corrupt state.

Besides, there's work currently going on to make printk safe in atomic
context so...

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
