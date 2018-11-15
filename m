From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] PCI fixes for v4.20
Date: Thu, 15 Nov 2018 13:13:07 -0500
Message-ID: <20181115181307.GA25806@pure.paranoia.local>
References: <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
 <20181114222154.GA22445@pure.paranoia.local>
 <20181114224839.GP13926@zn.tnic>
 <20181115071252.GB94998@google.com>
 <20181115075330.GA32162@pure.paranoia.local>
 <20181115150321.GB207836@google.com>
 <20181115155418.GA25764@pure.paranoia.local>
 <20181115172706.GA229449@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115172706.GA229449@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, pr-tracker-bot@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 15, 2018 at 11:27:06AM -0600, Bjorn Helgaas wrote:
> > > OK, I think I'll remove the insteadOf chunk from my .gitconfig.  Should
> > > https://korg.wiki.kernel.org/userdoc/gitolite be updated to remove or
> > > expand that recommendation?  The only reason I added insteadOf in the first
> > > place was because it sounded like a security improvement.
> > 
> > It is. Does adding the insteadOf rules result in ssh:// URLs when using
> > git-request-pull? I didn't expect that it would.
> 
> Yep, it seems to for me.  Maybe I'm doing something else weird, because I
> don't see many other pull requests with ssh:// URLs.

Hmm, you're right -- I just tested this and it does. I can't imagine
that's the intended effect of insteadOf -- it's supposed to alter URLs
behind the scenes, not permanently transform them. I'll talk to git
folks about it.

For now, you should probably remove that from your gitconfig so that
your pull requests have public URLs in them.

Best,
-K
