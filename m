From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH -v2 1/4] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
Date: Thu, 7 Apr 2011 18:39:53 +0100
Message-ID: <20110407173953.GB17049@n2100.arm.linux.org.uk>
References: <1302139746-1030-1-git-send-email-ying.huang@intel.com> <1302139746-1030-2-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1302139746-1030-2-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Chen Liqin <liqin.chen@sunplusct.com>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Chris Zankel <chris@zankel.net>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 07, 2011 at 09:29:03AM +0800, Huang Ying wrote:
> cmpxchg() is widely used by lockless code, including NMI-safe lockless
> code.  But on some architectures, the cmpxchg() implementation is not
> NMI-safe, on these architectures the lockless code may need to a
> spin_trylock_irqsave() based implementation.
> 
> This patch adds a Kconfig option: ARCH_HAVE_NMI_SAFE_CMPXCHG, so that
> NMI-safe lockless code can depend on it or provide different
> implementation according to it.
> 
> On many architectures, cmpxchg is only NMI-safe for several specific
> operand sizes. So, ARCH_HAVE_NMI_SAFE_CMPXCHG define in this patch
> only guarantees cmpxchg is NMI-safe for sizeof(unsigned long).

As this no longer touches any ARM code, I thinky you can drop me from the
CC list.  Thanks.
