From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/4] printk: Allocate kernel log buffer earlier
Date: Sun, 27 Feb 2011 13:15:18 +0100
Message-ID: <20110227121518.GA19165@elte.hu>
References: <20110225180633.857892225@gulag1.americas.sgi.com>
 <20110225180634.017570095@gulag1.americas.sgi.com>
 <20110227120949.GF16453@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:36830 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911Ab1B0MPf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Feb 2011 07:15:35 -0500
Content-Disposition: inline
In-Reply-To: <20110227120949.GF16453@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: David Rientjes <rientjes@google.com>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>


* Ingo Molnar <mingo@elte.hu> wrote:

> You could avoid all this ugly workaround of bootmem limitations by moving the 
> allocation to memblock_alloc() and desupporting the log_buf_len= boot parameter on 
> non-memblock architectures.

memblock_alloc() could return -ENOSYS on architectures that do not implement it - 
thus enabling such optional features without ugly #ifdef CONFIG_HAVE_MEMBLOCK 
conditionals.

Thanks,

	Ingo
