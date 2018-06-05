From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Device properties framework update for v4.18-rc1
Date: Tue, 5 Jun 2018 10:39:23 -0700
Message-ID: <CA+55aFw8yUOweiQSEp-ZHzEeSAGggZ0-Ksy0e4GQgEhKvmwLog@mail.gmail.com>
References: <CAJZ5v0jq45atkapwSjJ4DkHhB1bfOA-Sh1TiA3dPXwKyFTBheA@mail.gmail.com>
 <CA+55aFyoxvrA-7X_8ZfQXd1=GfLT96ZaHAM+o5gKwOOfiy_HDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFyoxvrA-7X_8ZfQXd1=GfLT96ZaHAM+o5gKwOOfiy_HDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 5, 2018 at 10:30 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, this looks questionable to me.
>
> I'm not talking about the changes themselves - I can live with them.
> But the _rationale_ is pure and utter garbage, and dangerously so.

Side note: I've merged it, and it's going through my build tests, so
it's really not that I hate the code.

But I really find that kind of one-sided rationale that ignores
reality unacceptable.

And I find it dangerous, because it *sounds* so "obviously correct" to
people who don't know any better. If you don't know that gcc
explicitly says that you should use unions to do type punning to avoid
aliasing issues, you might believe that union type punning is a bad
thing from that commit message.

So it's dangerously misleading, because lots of people have a
dangerous reverence for paper over reality.

In programming, "Appeal to Standards" should be considered a potential
logical fallacy. Standards have their place, but they definitely have
their caveats too.

                    Linus
