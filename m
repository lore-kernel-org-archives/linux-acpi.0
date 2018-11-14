From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] PCI fixes for v4.20
Date: Wed, 14 Nov 2018 17:21:54 -0500
Message-ID: <20181114222154.GA22445@pure.paranoia.local>
References: <20181114062010.GA189193@google.com>
 <20181114200003.14496.1490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114214601.GO13926@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, pr-tracker-bot@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 14, 2018 at 10:46:01PM +0100, Borislav Petkov wrote:
> > > that bot needs some parsing improvs: "None None".
> > 
> > Correct, this is because the original pull request was for an ssh://
> 
> You'd think Bjorn would know better... :-)))

For the record, there's nothing wrong with that, it's just a condition
that I didn't expect. I have a fix in place that should avoid this in
the future.

-K
