From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [BUG] 2.6.24 refuses to boot - NMI watchdog problem?
Date: Wed, 6 Feb 2008 00:26:05 +0000 (GMT)
Message-ID: <658272.2386.qm@web52902.mail.re2.yahoo.com>
References: <20080205153243.dadaace8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762654AbYBFA0X@vger.kernel.org>
In-Reply-To: <20080205153243.dadaace8.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--- Andrew Morton <akpm@linux-foundation.org> wrote:
> On Sat, 2 Feb 2008 23:36:42 +0000 (GMT)
> Chris Rankin <rankincj@yahoo.com> wrote:

> > I have a 1 GHz Coppermine PC with 512 MB RAM, and it is failing to boot with the
> nmi_watchdog=1
> > option. This kernel was rebuilt after doing a "make mrproper". The dmesg log follows:
> 
> Can you tell us if earlier kernels worked OK, and if so which version(s)?
> From your other mail it appears that 2.6.23 was OK?

Oh yes, 2.6.23.14 is fine with nmi_watchdog=1. (This is on a UP machine with a SMP/PREEMPT kernel,
BTW. "Just for fun.")

Cheers,
Chris



      __________________________________________________________
Sent from Yahoo! Mail - a smarter inbox http://uk.mail.yahoo.com
