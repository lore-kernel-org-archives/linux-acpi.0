From: David Mosberger <davidm@napali.hpl.hp.com>
Subject: RE: [ACPI] [PATCH] add acpi_interrupt_to_irq
Date: Thu, 22 Jan 2004 11:08:01 -0800
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <16400.8081.221616.319730@napali.hpl.hp.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A2D@hdsmsx402.hd.intel.com>
Reply-To: davidm@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8A2D@hdsmsx402.hd.intel.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "Nakajima, Jun" <jun.nakajima@intel.com>, acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

>>>>> On Thu, 22 Jan 2004 12:41:10 -0500, "Brown, Len" <len.brown@intel.com> said:

  Len> Bjorn,
  >> irq = acpi_irq_to_vector(irq);

  Len> Yeah, this name is totally bogus; and your comments are
  Len> absolutely right.  I thank you for taking the time to address
  Len> it.

  Len> When I first saw this I said to myself, "hmm, shouldn't it be
  Len> acpi_irq_to_irq()?", nah, that seems even more stupid!";-)

  Len> Looks like this is only used for the SCI listed in the FADT.
  Len> So maybe we should just call it something like
  Len> acpi_fadt_sci_to_irq()?

It would be good to come up with a consistent naming scheme.  I/we
tried to do that in the ia64/iosapic.c, but it might need some
updating/revising with recent changes (such as MSIs).  Perhaps "gsi"
is also a contender for the ACPI interrupts.

	--david
