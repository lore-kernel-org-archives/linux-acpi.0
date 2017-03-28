From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] ftrace/x86: fix x86-32 triple fault with graph tracing
 and suspend-to-ram
Date: Tue, 28 Mar 2017 11:39:41 -0400
Message-ID: <20170328113941.37469c9b@gandalf.local.home>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
        <20170324181254.gouyrbmppukrrbb6@treble>
        <20170324144114.16a37d47@gandalf.local.home>
        <5766300.HtmE7iLEgV@aspire.rjw.lan>
        <20170327140843.fx5y32rnc3mqiyke@treble>
        <20170327145441.aybim6rmc6nxelij@treble>
        <d8fd5cfd-e273-ad29-9281-2436cb0c3723@molgen.mpg.de>
        <918c4518-f4ca-0b94-6a28-3996be68469a@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbdC1Pjw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 11:39:52 -0400
In-Reply-To: <918c4518-f4ca-0b94-6a28-3996be68469a@molgen.mpg.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, 28 Mar 2017 11:51:45 +0200
Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> With both patches applied `./analyze_suspend.py -config 
> suspend-callgraph.cfg -filter i915` succeeds on a Lenovo X60t, so 
> suspend and resume work perfectly, when tracing is enabled.
> 
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> It’d be awesome, if you could tag both patches for inclusion into the 
> stable Linux Kernel series.

As long as they are not dependent on my patch series, I'm fine with
these going to stable.

-- Steve
