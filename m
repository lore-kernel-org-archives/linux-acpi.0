From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [GIT PULL] PCI fixes for v4.20
Date: Thu, 15 Nov 2018 01:12:53 -0600
Message-ID: <20181115071252.GB94998@google.com>
References: <20181114062010.GA189193@google.com>
 <20181114200003.14496.1490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
 <20181114222154.GA22445@pure.paranoia.local>
 <20181114224839.GP13926@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114224839.GP13926@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, pr-tracker-bot@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 14, 2018 at 11:48:39PM +0100, Borislav Petkov wrote:
> On Wed, Nov 14, 2018 at 05:21:54PM -0500, Konstantin Ryabitsev wrote:
> > For the record, there's nothing wrong with that, it's just a condition
> > that I didn't expect. I have a fix in place that should avoid this in
> > the future.
> 
> Actually, I meant the pull request URL.

My pull request URL was this:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-1

> Here's some background info:
> 
> https://lkml.kernel.org/r/CA%2B55aFyMxkS=8JzZ%2BROOAFkwR45EKBnQ0GUMQS4f%2Br_-fFWiEA@mail.gmail.com
> 
> and I kinda see the point of maybe not having your ssh username in the
> URL. Not that it is a big deal for us, k.org users though.

Sorry, I don't understand the problem.  I have this in my .gitconfig:

    [url "ssh://git@gitolite.kernel.org"]
	    insteadOf = https://git.kernel.org
	    insteadOf = http://git.kernel.org
	    insteadOf = git://git.kernel.org

because I thought that was the recommended way (see the end of
https://korg.wiki.kernel.org/userdoc/gitolite). But that also makes my
request-pull:

    $ git request-pull origin/master git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v4.20-fixes-1

generate the ssh URL above.  If I remove the insteadOf stuff from
.gitconfig, request-pull produces this instead:

    git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-1

I'm happy to do either; just tell me which :)

Bjorn
