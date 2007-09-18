From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC] module to support ACPI AML calls to native firmware
Date: Tue, 18 Sep 2007 16:53:28 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A0274F144@scsmsx411.amr.corp.intel.com>
References: <200709111714.57095.bjorn.helgaas@hp.com> <200709131711.15015.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-reply-to: <200709131711.15015.bjorn.helgaas@hp.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> If you don't object to the two patches, can you incorporate them
> as originally posted?  If you'd prefer a different approach, I'd
> be happy to rework them, of course.

I think that adding 4K to the kernel (about 0.04% increase looking
at a recent build ... or 0.0001% of total memory on a 4G system) isn't
really a big deal.  I'd rather do that than export all the fw_call_*()
functions for all the world to see.

If there is some other reason why the exports are needed, then the
names may have to change ... these are ia64 specific routines, but
the fw_call_*() names sound very generic.

-Tony
