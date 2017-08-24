From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] nfit: Use init_completion() in acpi_nfit_flush_probe()
Date: Thu, 24 Aug 2017 15:46:26 +0200
Message-ID: <CAK8P3a1bVCxJCi_84abo4Bk7LFr7ynO1=7bW5dm=jbLvH9sR2Q@mail.gmail.com>
References: <20170823152542.5150-1-boqun.feng@gmail.com> <20170823152542.5150-2-boqun.feng@gmail.com>
 <alpine.DEB.2.20.1708241507160.1860@nanos> <20170824132801.GM11771@tardis>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36783 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdHXNq1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Aug 2017 09:46:27 -0400
In-Reply-To: <20170824132801.GM11771@tardis>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Michel Lespinasse <walken@google.com>, Byungchul Park <byungchul.park@lge.com>, Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, Nicholas Piggin <npiggin@gmail.com>, kernel-team@lge.com, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-nvdimm@lists.01.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Aug 24, 2017 at 3:28 PM, Boqun Feng <boqun.feng@gmail.com> wrote:
> On Thu, Aug 24, 2017 at 03:07:42PM +0200, Thomas Gleixner wrote:
>> On Wed, 23 Aug 2017, Boqun Feng wrote:
>>
>> > There is no need to use COMPLETION_INITIALIZER_ONSTACK() in
>> > acpi_nfit_flush_probe(), replace it with init_completion().
>>
>> You completely fail to explain WHY.
>>
>
> I thought COMPLETION_INITIALIZER_ONSTACK() should only use in assigment
> or compound literals, so the usage here is obviously wrong, but seems
> I was wrong?
>
> Ingo,
>
> Is the usage of COMPLETION_INITIALIZER_ONSTACK() correct? If not,
> I could rephrase my commit log saying this is a fix for wrong usage of
> COMPLETION_INITIALIZER_ONSTACK(), otherwise, I will rewrite the commit
> indicating this patch is a necessary dependency for patch #2. Thanks!

I think your patch is correct, but your changelog text is useless, as
Thomas mentioned: you should instead explain that it breaks with the
other fix in the series, and what the difference between init_completion()
and COMPLETION_INITIALIZER_ONSTACK() is.

      Arnd
