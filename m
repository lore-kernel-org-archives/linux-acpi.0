From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/5] x86: Minimize initial e820 messages
Date: Fri, 18 Feb 2011 08:30:32 +0100
Message-ID: <20110218073032.GD11404@elte.hu>
References: <20110217185131.960038922@gulag1.americas.sgi.com>
 <20110217185132.267615941@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:53788 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879Ab1BRHar (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Feb 2011 02:30:47 -0500
Content-Disposition: inline
In-Reply-To: <20110217185132.267615941@gulag1.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org


* Mike Travis <travis@sgi.com> wrote:

> --- linux.orig/arch/x86/kernel/e820.c
> +++ linux/arch/x86/kernel/e820.c
> @@ -38,6 +38,8 @@
>   */
>  struct e820map e820;
>  struct e820map e820_saved;
> +struct e820map e820_prev __initdata;
> +int e820_prev_saved __initdata;

Please add comments to the code that describe what these global variables do.

Also, they should be 'static' as they are only used in e820.c, right?

	Ingo
