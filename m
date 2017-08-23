From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] nfit: Use init_completion() in acpi_nfit_flush_probe()
Date: Wed, 23 Aug 2017 15:08:41 -0700
Message-ID: <CAPcyv4gidDb7BMejTiLaQu1KPB8XWzMcp_QeT4NiknPWvdNHxg@mail.gmail.com>
References: <20170823152542.5150-1-boqun.feng@gmail.com> <20170823152542.5150-2-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35680 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdHWWIo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Aug 2017 18:08:44 -0400
Received: by mail-oi0-f53.google.com with SMTP id r200so14451999oie.2
        for <linux-acpi@vger.kernel.org>; Wed, 23 Aug 2017 15:08:44 -0700 (PDT)
In-Reply-To: <20170823152542.5150-2-boqun.feng@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, walken@google.com, Byungchul Park <byungchul.park@lge.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, kernel-team@lge.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, Aug 23, 2017 at 8:25 AM, Boqun Feng <boqun.feng@gmail.com> wrote:
> There is no need to use COMPLETION_INITIALIZER_ONSTACK() in
> acpi_nfit_flush_probe(), replace it with init_completion().

Now that I see the better version of this patch with the improved
changelog in the -mm tree...

Acked-by: Dan Williams <dan.j.williams@intel.com>
