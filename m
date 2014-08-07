From: Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] x86/apic changes for v3.17
Date: Thu, 7 Aug 2014 15:31:48 +0200
Message-ID: <20140807133148.GC10043@pd.tnic>
References: <1407209178-18644-1-git-send-email-jiang.liu@linux.intel.com>
 <1407209178-18644-2-git-send-email-jiang.liu@linux.intel.com>
 <20140805183729.GA23068@pd.tnic>
 <53E201FC.6010102@linux.intel.com>
 <20140806170937.GA4895@pd.tnic>
 <20140807110332.GB10043@pd.tnic>
 <20140807113346.GA24225@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140807113346.GA24225@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jiang Liu <jiang.liu@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@linaro.org>, x86@kernel.org, Len Brown <lenb@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 07, 2014 at 01:33:46PM +0200, Ingo Molnar wrote:
> Linus, please pull the latest x86-apic-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

This tree still needs the suspend/resume fixes on this thread AFAICT.
Like keeping IRQ numbers of PCI devices stable across a s/r cycle, for
example.

I'm guessing you'll send Linus a follow-up pull request with those
later, right?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
