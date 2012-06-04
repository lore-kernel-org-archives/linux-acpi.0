From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] ACPI & Power Management Patches for Linux-3.5-merge
Date: Mon, 4 Jun 2012 02:03:29 +0200
Message-ID: <201206040203.29928.rjw@sisk.pl>
References: <4FC9B39B.403@kernel.org> <CA+55aFyGqZnVvd5-ZLUkS=EE72QG1FqempZrs+vBLyCkWP6T_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFyGqZnVvd5-ZLUkS=EE72QG1FqempZrs+vBLyCkWP6T_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday, June 03, 2012, Linus Torvalds wrote:
> On Fri, Jun 1, 2012 at 11:32 PM, Len Brown <lenb@kernel.org> wrote:
> >
> > ps. Sorry for sending this request at the tails of the merge window --
> > I'll try to be earlier next time.
> 
> Christ, not only is it after I really wanted to do -rc1 (held up by
> the tty locking problems), but it doesn't even compile.
> 
> Find the bug (the compiler certainly did):
> 
> static inline int acpi_pm_device_sleep_state(struct device *d, int *p, int m)
> {
>         if (p)
>                 *p = ACPI_STATE_D0;
>         return (m >= ACPI_STATE_D0 && <= ACPI_STATE_D3) ? m : ACPI_STATE_D0;
> }
> 
> and no, it wasn't a merge error. That's what it looks like in your tree.
> 
> The commit was done yesterday. It clearly had *zero* testing.
> 
> Looking more at the pull as a result of this, I notice that almost
> every commit in that tree is from yesterday, and thus cleary cannot
> have been in -next. I was going to just fix up the obvious one-liner
> fixup, but looking at the bigger picture I'm going to say "3.6
> material" for this whole thing.

Well, perhaps you could take my branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-acpi

which was included into the Len's pull, for 3.5?

It was ready a few days ago, and has been present in linux-next even longer
and contains fixes for real bugs.  I didn't push it myself, because it
generally is ACPI material, but since you're not going to take the Len's
tree now, can you please consider taking that branch at least?

Rafael
