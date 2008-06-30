From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 5/5] x86 PCI: use dev_printk when possible
Date: Mon, 30 Jun 2008 16:57:37 -0700
Message-ID: <20080630165737.2f9735f0.akpm@linux-foundation.org>
References: <20080613165209.507694130@ldl.fc.hp.com>
	<20080613165304.842091464@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20080613165304.842091464@ldl.fc.hp.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: lenb@kernel.org, jbarnes@virtuousgeek.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 13 Jun 2008 10:52:14 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> I converted DBG() to dev_dbg().  This DBG() is from arch/x86/pci/pci.h
> and requires source-code modification to enable, so dev_dbg() seems
> roughly equivalent.
> 
> The printks in arch/x86/pci/irq.c were a little hairy, with lines
> printed in several pieces.  I straightened it out a little, but
> another set of eyes would be good.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> ---
>  arch/x86/pci/fixup.c |    3 +
>  arch/x86/pci/i386.c  |   26 ++++++--------
>  arch/x86/pci/irq.c   |   91 ++++++++++++++++++++++-----------------------------
>  arch/x86/pci/numa.c  |    5 +-

Got a bunch of rejects in arch/x86/pci/irq.c due to pending whitespace
fixes.  I fixed a couple of them but then I got bored, so the
conversion in there is only partial.

Please prefer to raise patches against linux-next if poss, especially
during late -rc's.
