From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [GIT PULL] Device properties framework update for v4.18-rc1
Date: Wed, 06 Jun 2018 10:45:05 +0300
Message-ID: <2fe122f7fa0040509dcc049b48e7934b54ee0a55.camel@linux.intel.com>
References: <CAJZ5v0jq45atkapwSjJ4DkHhB1bfOA-Sh1TiA3dPXwKyFTBheA@mail.gmail.com>
         <CA+55aFyoxvrA-7X_8ZfQXd1=GfLT96ZaHAM+o5gKwOOfiy_HDA@mail.gmail.com>
         <CA+55aFw8yUOweiQSEp-ZHzEeSAGggZ0-Ksy0e4GQgEhKvmwLog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFw8yUOweiQSEp-ZHzEeSAGggZ0-Ksy0e4GQgEhKvmwLog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2018-06-05 at 10:39 -0700, Linus Torvalds wrote:
> On Tue, Jun 5, 2018 at 10:30 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > 
> > Honestly, this looks questionable to me.
> > 
> > I'm not talking about the changes themselves - I can live with them.
> > But the _rationale_ is pure and utter garbage, and dangerously so.
> 
> Side note: I've merged it, and it's going through my build tests, so
> it's really not that I hate the code.

Thanks for merging.

> 
> But I really find that kind of one-sided rationale that ignores
> reality unacceptable.

Yeah, there were few reasons why I decide to make that patch (OK, it
seems I staked on not the best reason).

Like Rafael said there is no need to use it here and code initially was
without union aliasing be in place.

> And I find it dangerous, because it *sounds* so "obviously correct" to
> people who don't know any better. If you don't know that gcc
> explicitly says that you should use unions to do type punning to avoid
> aliasing issues, you might believe that union type punning is a bad
> thing from that commit message.
> 
> So it's dangerously misleading, because lots of people have a
> dangerous reverence for paper over reality.

I agree with you, because type punning via unions feels natural and
that's why I even didn't notice when made a refactoring there several
releases before.

> In programming, "Appeal to Standards" should be considered a potential
> logical fallacy. Standards have their place, but they definitely have
> their caveats too.

Yes, even outside of programming.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
