From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] acpi: fix incompatibility with mcount-based function
 graph tracing
Date: Fri, 24 Mar 2017 14:41:14 -0400
Message-ID: <20170324144114.16a37d47@gandalf.local.home>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
        <c6c72c7a0199bc79fdbe2318713e35d9@molgen.mpg.de>
        <20170324181254.gouyrbmppukrrbb6@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934744AbdCXSlT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:19 -0400
In-Reply-To: <20170324181254.gouyrbmppukrrbb6@treble>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>

On Fri, 24 Mar 2017 13:12:54 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:


> Instead I was able to "fix" it by ignoring ftrace calls in real mode:
> 
> -----
> index 8f3d9cf..5c0d0c6 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -983,6 +983,9 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
>  	unsigned long return_hooker = (unsigned long)
>  				&return_to_handler;
>  
> +	if (__builtin_return_address(0) < TASK_SIZE_MAX)
> +		return;
> +
>  	if (unlikely(ftrace_graph_is_dead()))
>  		return;
> ---------------
> 
> I'm not sure what the best fix should really be.  A few ideas off the
> top of my head:
> 
> - A real mode check similar to the above (except it should probably be
>   more precise)

The real mode check hack may be good enough for now. Make sure that
it's commented well.

-- Steve

> 
> - Make tracing_graph_pause a percpu variable so that it can be read from
>   prepare_ftrace_return()
> 
> - pause_graph_tracing() from ftrace_suspend_notifier_call()
> 
> Steven, thoughts?
> 

