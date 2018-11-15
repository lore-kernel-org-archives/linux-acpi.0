From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [GIT PULL] PCI fixes for v4.20
Date: Thu, 15 Nov 2018 11:27:06 -0600
Message-ID: <20181115172706.GA229449@google.com>
References: <20181114200003.14496.1490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
 <20181114222154.GA22445@pure.paranoia.local>
 <20181114224839.GP13926@zn.tnic>
 <20181115071252.GB94998@google.com>
 <20181115075330.GA32162@pure.paranoia.local>
 <20181115150321.GB207836@google.com>
 <20181115155418.GA25764@pure.paranoia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115155418.GA25764@pure.paranoia.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>, pr-tracker-bot@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 15, 2018 at 10:54:18AM -0500, Konstantin Ryabitsev wrote:
> On Thu, Nov 15, 2018 at 09:03:21AM -0600, Bjorn Helgaas wrote:
> > > You didn't really do anything wrong. In *general* I prefer to see
> > > public URLs if they are sent to public lists, so if you're cc'ing
> > > something to LKML, I would generally expect the pull request to have a
> > > public URL like https://git.kernel.org/ instead of a private ssh:// URL
> > > that is only accessible to people with a kernel.org account.
> > > 
> > > That's basically all there is to it. It doesn't *really* matter, since
> > > Linus is the one who will be merging the actual pull request, and he
> > > certainly has access to internal ssh:// URLs. However, in case someone
> > > else was interested in reviewing the pull request, it would be more
> > > friendly to have a public URL for them.
> > 
> > OK, I think I'll remove the insteadOf chunk from my .gitconfig.  Should
> > https://korg.wiki.kernel.org/userdoc/gitolite be updated to remove or
> > expand that recommendation?  The only reason I added insteadOf in the first
> > place was because it sounded like a security improvement.
> 
> It is. Does adding the insteadOf rules result in ssh:// URLs when using
> git-request-pull? I didn't expect that it would.

Yep, it seems to for me.  Maybe I'm doing something else weird, because I
don't see many other pull requests with ssh:// URLs.
