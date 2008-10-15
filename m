From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 53/85] i7300_idle driver v1.55
Date: Wed, 15 Oct 2008 18:32:30 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810151822520.3026@localhost.localdomain>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
 <e8b529091b2ab65f5a4783e292c2b472e309116e.1223706853.git.len.brown@intel.com>
 <20081011083347.GA31918@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755955AbYJOWcv@vger.kernel.org>
In-reply-to: <20081011083347.GA31918@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Andy Henroid <andrew.d.henroid@intel.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-acpi@vger.kernel.org



> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -62,6 +62,13 @@ void idle_notifier_register(struct notifier_block *n)
> >  {
> >  	atomic_notifier_chain_register(&idle_notifier, n);
> >  }
> > +EXPORT_SYMBOL_GPL(idle_notifier_register);
> > +
> > +void idle_notifier_unregister(struct notifier_block *n)
> > +{
> > +	atomic_notifier_chain_unregister(&idle_notifier, n);
> > +}
> > +EXPORT_SYMBOL_GPL(idle_notifier_unregister);
> 
> hm, such x86 infrastructure changes should be submitted via the x86 
> tree, and you should at least have Cc:-ed the maintainers.

I agree that this patch did not hit the list in the conventional way.
I apologize for that, and I thank you, Ingo, for noticing the patch.

> The thing is, we are _getting rid_ of the idle notifiers, not extending 
> them. The last thing we need is random opaque stuff getting called in 
> weird ordering when we enter/exit idle state. We want all that be 
> visible and have explicit, in-source-code ordering.

The patch on the table is basically a platform (chipset) idle hook.
When the system is very idle, it saves energy in the memory sub-system.
Linux customers are asking for this capability b/c it allows them
to save energy and save money.

We considered putting a platform hook into the cpuidle code,
but it seemed simpler this way -- since the new platform hook
would end up looking almost exactly like the idle notifier
that we have already.  So x86-wise, all we did here is
expose the register/unregister so the driver can be modular.

I'm certainly open to suggestions.

thanks,
-Len
