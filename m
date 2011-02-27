From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/4] printk: Break out printk_time
Date: Sun, 27 Feb 2011 12:56:04 +0100
Message-ID: <20110227115604.GD16453@elte.hu>
References: <20110225180633.857892225@gulag1.americas.sgi.com>
 <20110225180634.147732905@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:55494 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab1B0L4W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Feb 2011 06:56:22 -0500
Content-Disposition: inline
In-Reply-To: <20110225180634.147732905@gulag1.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: David Rientjes <rientjes@google.com>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org


* Mike Travis <travis@sgi.com> wrote:

> +			/* add time if requested */
> +			if (printk_time)
> +				printed_len += printk_emit_time();

Why isnt't the printk_time condition pushed into printk_emit_time() as well?

Thanks,

	Ingo
