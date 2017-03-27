From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] trace: Make trace_hwlat timestamp y2038 safe
Date: Mon, 27 Mar 2017 11:30:28 -0400
Message-ID: <20170327113028.7f74c9b8@gandalf.local.home>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
        <20170324181254.gouyrbmppukrrbb6@treble>
        <20170324144114.16a37d47@gandalf.local.home>
        <5766300.HtmE7iLEgV@aspire.rjw.lan>
        <20170327140843.fx5y32rnc3mqiyke@treble>
        <CAK8P3a2Tm0qFiMx7VgK8bprncCCJ_w0ePrqPU3ex4LVm4fceaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752764AbdC0Pa7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Mar 2017 11:30:59 -0400
In-Reply-To: <CAK8P3a2Tm0qFiMx7VgK8bprncCCJ_w0ePrqPU3ex4LVm4fceaw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon, 27 Mar 2017 16:53:09 +0200
Arnd Bergmann <arnd@arndb.de> wrote:


> > Actually, I believe that "%zd" will work. It's made to work with size_t
> > which is long long on 32 and long on 64.  
> 
> size_t is always 'long', not 'long long'. We have %pad for dma_addr_t
> which may be 'long' or 'long long', but it is configuration dependent
> which one it is on 32-bit.

Ah your right. It was that it was defined as "int" on 32 and "long" on
64, and that caused problems with warnings when using "%d" when it was
defined as long.

> 
> We could probably introduce a %pts format string for timespec64
> and have that pretty-printed.

Hmm, probably don't want a %p as that suggests its a pointer, which it
should not be. Unless we pass in the address of the number.

-- Steve
