From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] ACPI using smp_processor_id in preemptible code
Date: Mon, 10 Jan 2005 10:55:08 +0100
Message-ID: <20050110095508.GJ1353@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262024AbVAJJ4a@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >I enabled CPU hotplug and preemptible debugging... now I get...
> >
> >BUG: using smp_processor_id() in preemptible [00000001] code:
> >swapper/0
> >caller is acpi_processor_idle+0xb/0x235
> > [<c020ba28>] smp_processor_id+0xa8/0xc0
> > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > [<c0101115>] cpu_idle+0x75/0x110
> > [<c04f5988>] start_kernel+0x158/0x180
> > [<c04f5390>] unknown_bootoption+0x0/0x1e0
> It doesn't trouble to me. It's in idle thread.

You mean it does not happen to you? On my machine it fills logs very
quickly...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
