From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] trace: Make trace_hwlat timestamp y2038 safe
Date: Mon, 27 Mar 2017 17:35:13 +0200
Message-ID: <CAK8P3a1-Fpkg-d0k9HryqW4ULVfZPL6_McLxoFbUT6CTmMoMFg@mail.gmail.com>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
 <20170324181254.gouyrbmppukrrbb6@treble> <20170324144114.16a37d47@gandalf.local.home>
 <5766300.HtmE7iLEgV@aspire.rjw.lan> <20170327140843.fx5y32rnc3mqiyke@treble>
 <CAK8P3a2Tm0qFiMx7VgK8bprncCCJ_w0ePrqPU3ex4LVm4fceaw@mail.gmail.com> <20170327113028.7f74c9b8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35897 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdC0PfT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2017 11:35:19 -0400
In-Reply-To: <20170327113028.7f74c9b8@gandalf.local.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon, Mar 27, 2017 at 5:30 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 27 Mar 2017 16:53:09 +0200
>> We could probably introduce a %pts format string for timespec64
>> and have that pretty-printed.
>
> Hmm, probably don't want a %p as that suggests its a pointer, which it
> should not be. Unless we pass in the address of the number.

The special format strings that the kernel defines all start with %p and
require passing by reference so we don't get a warning from gcc. We can't
just make up new format strings otherwise, but we can create new meaning
for special pointers as we do for struct resource and others.

       Arnd
