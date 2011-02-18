From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 5/5] printk: Allocate kernel log buffer earlier
Date: Fri, 18 Feb 2011 08:40:15 +0100
Message-ID: <20110218074015.GG11404@elte.hu>
References: <20110217185131.960038922@gulag1.americas.sgi.com>
 <20110217185132.735139933@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:58068 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753352Ab1BRHk3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Feb 2011 02:40:29 -0500
Content-Disposition: inline
In-Reply-To: <20110217185132.735139933@gulag1.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org


* Mike Travis <travis@sgi.com> wrote:

> +++ linux/kernel/printk.c
> @@ -162,46 +162,65 @@ void log_buf_kexec_setup(void)
>  }
>  #endif
>  
> +static unsigned long __initdata new_log_buf_len;
>  static int __init log_buf_len_setup(char *str)
>  {

Can you see the readability problem this new line introduces?

> +	char first_line[64], *first_nl;

The value 64 looks arbitrary. Needs to be symbolized and explained. (That would also 
make the sizeof(first_line) usage more readable later on.)

> +	pr_info("log_buf_len: %d, first line: %s\n",
> +		log_buf_len, first_line);

It's not just arbitrarily sized, but i dont see where it's guaranteed that it's a 
nil delimited string.

> +	pr_debug("bu: %d/%d (%d%%)\n",
> +		dest_idx, __LOG_BUF_LEN - dest_idx,
> +		(dest_idx * 100) / __LOG_BUF_LEN);

What's that?

Patch looks pretty ad-hoc. No comments whatsoever what the intention is either, so 
the reader has to go figure out the code.

Thanks,

	Ingo
