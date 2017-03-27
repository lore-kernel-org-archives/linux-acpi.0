From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] ftrace/x86: fix x86-32 triple fault with graph tracing
 and suspend-to-ram
Date: Mon, 27 Mar 2017 11:24:33 -0400
Message-ID: <20170327112433.728ba8c1@gandalf.local.home>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
        <20170324181254.gouyrbmppukrrbb6@treble>
        <20170324144114.16a37d47@gandalf.local.home>
        <5766300.HtmE7iLEgV@aspire.rjw.lan>
        <20170327140843.fx5y32rnc3mqiyke@treble>
        <20170327145441.aybim6rmc6nxelij@treble>
        <d8fd5cfd-e273-ad29-9281-2436cb0c3723@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752607AbdC0PYm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Mar 2017 11:24:42 -0400
In-Reply-To: <d8fd5cfd-e273-ad29-9281-2436cb0c3723@molgen.mpg.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon, 27 Mar 2017 17:01:53 +0200
Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> > +	/*
> > +	 * When resuming from suspend-to-ram, this function can be indirectly
> > +	 * called from early CPU startup code while the CPU is in real mode,
> > +	 * which would fail miserably.  Make sure the stack pointer is a
> > +	 * virtual address.
> > +	 *
> > +	 * This check isn't as accurate as virt_addr_valid(), but it should be
> > +	 * good enough for this purpose, and it's fast.
> > +	 */
> > +	if (unlikely((long)__builtin_frame_address(0) >= 0)) return;  
> 
> The coding style requires the `return;` to be on a separate line.

Correct, and new versions of a patch should always start a new thread
(unless it's a single update of a patch in a long patch series).
Otherwise they get ignored. (hint hint)

-- Steve



> 
> > +
> >  	if (unlikely(ftrace_graph_is_dead()))
> >  		return;  
> 
