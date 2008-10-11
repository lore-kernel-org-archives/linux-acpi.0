From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 53/85] i7300_idle driver v1.55
Date: Sat, 11 Oct 2008 10:33:47 +0200
Message-ID: <20081011083347.GA31918@elte.hu>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com> <e8b529091b2ab65f5a4783e292c2b472e309116e.1223706853.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51058 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbYJKIeF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Oct 2008 04:34:05 -0400
Content-Disposition: inline
In-Reply-To: <e8b529091b2ab65f5a4783e292c2b472e309116e.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Andy Henroid <andrew.d.henroid@intel.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>


Len,

* Len Brown <lenb@kernel.org> wrote:

> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -62,6 +62,13 @@ void idle_notifier_register(struct notifier_block *n)
>  {
>  	atomic_notifier_chain_register(&idle_notifier, n);
>  }
> +EXPORT_SYMBOL_GPL(idle_notifier_register);
> +
> +void idle_notifier_unregister(struct notifier_block *n)
> +{
> +	atomic_notifier_chain_unregister(&idle_notifier, n);
> +}
> +EXPORT_SYMBOL_GPL(idle_notifier_unregister);

hm, such x86 infrastructure changes should be submitted via the x86 
tree, and you should at least have Cc:-ed the maintainers.

The thing is, we are _getting rid_ of the idle notifiers, not extending 
them. The last thing we need is random opaque stuff getting called in 
weird ordering when we enter/exit idle state. We want all that be 
visible and have explicit, in-source-code ordering.

	Ingo
