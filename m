From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] Re: APM good, ACPI bad (2.6.2-rc1 / p4 HT / Uniwill N258SA0)
Date: Tue, 3 Feb 2004 10:30:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040203093044.GB408@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401CBB670@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB670@PDSMSX403.ccr.corp.intel.com>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Huw Rogers <count0@localnet.com>, linux-kernel@vger.kernel.org, ncunningham@users.sourceforge.net, linux-laptop@mobilix.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> > [Do *not* enable suspend on SMP for mainline, unless you are willing
> > to audit that code...]
> 
> When do you want to have SMP support ? This is a laptop having HT.

Well, I want to have it two years ago... but its not there.

Original idea was to wait for CPU hotplug patches (hot-unplug all
other CPUs so we don't have to deal with locking), but cpu hotplug is
unlikely to make it into 2.6 at this point...

Plus I do not have easy access to SMP machine...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
