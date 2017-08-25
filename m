From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/2] nfit: Fix the abuse of COMPLETION_INITIALIZER_ONSTACK()
Date: Thu, 24 Aug 2017 17:36:22 -0700
Message-ID: <CAPcyv4gHgdpyqbv8gs5MiEtEHSdC-JLhutdfn81fhQ1woQSh_Q@mail.gmail.com>
References: <20170823152542.5150-2-boqun.feng@gmail.com> <20170824142239.15178-1-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170824142239.15178-1-boqun.feng@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Michel Lespinasse <walken@google.com>, Byungchul Park <byungchul.park@lge.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, kernel-team@lge.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 24, 2017 at 7:22 AM, Boqun Feng <boqun.feng@gmail.com> wrote:
> COMPLETION_INITIALIZER_ONSTACK() is supposed to used as an initializer,
> in other words, it should only be used in assignment expressions or
> compound literals. So the usage in drivers/acpi/nfit/core.c:
>
>         COMPLETION_INITIALIZER_ONSTACK(flush.cmp);
>
> , is inappropriate.
>
> Besides, this usage could also break compilations for another fix to
> reduce stack sizes caused by COMPLETION_INITIALIZER_ONSTACK(), because
> that fix changes COMPLETION_INITIALIZER_ONSTACK() from rvalue to lvalue,
> and usage as above will report error:
>
>         drivers/acpi/nfit/core.c: In function 'acpi_nfit_flush_probe':
>         include/linux/completion.h:77:3: error: value computed is not used [-Werror=unused-value]
>           (*({ init_completion(&work); &work; }))
>
> This patch fixes this by replacing COMPLETION_INITIALIZER_ONSTACK() with
> init_completion() in acpi_nfit_flush_probe(), which does the same
> initialization without any other problem.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
