From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] PCI fixes for v4.20
Date: Thu, 15 Nov 2018 02:53:30 -0500
Message-ID: <20181115075330.GA32162@pure.paranoia.local>
References: <20181114062010.GA189193@google.com>
 <20181114200003.14496.1490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
 <20181114222154.GA22445@pure.paranoia.local>
 <20181114224839.GP13926@zn.tnic>
 <20181115071252.GB94998@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115071252.GB94998@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, pr-tracker-bot@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 15, 2018 at 01:12:53AM -0600, Bjorn Helgaas wrote:
> > and I kinda see the point of maybe not having your ssh username in the
> > URL. Not that it is a big deal for us, k.org users though.
> 
> Sorry, I don't understand the problem.  I have this in my .gitconfig:
> 
>     [url "ssh://git@gitolite.kernel.org"]
> 	    insteadOf = https://git.kernel.org
> 	    insteadOf = http://git.kernel.org
> 	    insteadOf = git://git.kernel.org
> 
> because I thought that was the recommended way (see the end of
> https://korg.wiki.kernel.org/userdoc/gitolite). But that also makes my
> request-pull:
> 
>     $ git request-pull origin/master git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v4.20-fixes-1
> 
> generate the ssh URL above.  If I remove the insteadOf stuff from
> .gitconfig, request-pull produces this instead:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-1
> 
> I'm happy to do either; just tell me which :)

You didn't really do anything wrong. In *general* I prefer to see
public URLs if they are sent to public lists, so if you're cc'ing
something to LKML, I would generally expect the pull request to have a
public URL like https://git.kernel.org/ instead of a private ssh:// URL
that is only accessible to people with a kernel.org account.

That's basically all there is to it. It doesn't *really* matter, since
Linus is the one who will be merging the actual pull request, and he
certainly has access to internal ssh:// URLs. However, in case someone
else was interested in reviewing the pull request, it would be more
friendly to have a public URL for them.

Best,
-K
