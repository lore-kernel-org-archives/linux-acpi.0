From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [ACPI] Re: [PATCH] ACPI PCI IRQ routing rework
Date: Mon, 17 May 2004 09:41:35 -0600
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <200405170941.35673.bjorn.helgaas@hp.com>
References: <941A6821ACE16D4BBB8A958A0EB047F7264554@pdsmsx404.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <941A6821ACE16D4BBB8A958A0EB047F7264554@pdsmsx404.ccr.corp.intel.com>
Content-Disposition: inline
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: acpi-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>, David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday 17 May 2004 3:58 am, Li, Shaohua wrote:
> For the IOSAPIC, your patch mask interrupts in initialization, but
> should we mask platform interrupt?

I mask the interrupt in the IOSAPIC when programming the RTE.
This IOSAPIC programming happens before request_irq(), so I
think it makes sense to leave the RTE masked, because there's
nothing set up to do anything with an interrupt if it occurs.

If somebody's actually interested in the interrupt, there should
be a later request_irq() call, which will unmask the RTE via the
request_irq->setup_irq->startup path.

The only ia64 platform interrupt we do anything with is
ACPI_INTERRUPT_CPEI.  My usual test boxes don't support CPEI,
but from reading the code, iosapic_register_platform_intr()
programs the RTE (leaving it masked) when we parse the MADT.
Then ia64_mca_init() looks up the vector assigned for CPEI
and calls setup_irq() for it, which will unmask the RTE.

Maybe we could do a little rework to make ia64_mca_init() use
request_irq() (similar to how acpi_os_install_interrupt_handler()
works), but I think the current scheme should work.  Or do you
have evidence to the contrary?

Bjorn
