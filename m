From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC] module to support ACPI AML calls to native firmware
Date: Wed, 19 Sep 2007 09:49:32 -0600
Message-ID: <200709190949.32750.bjorn.helgaas@hp.com>
References: <200709111714.57095.bjorn.helgaas@hp.com> <200709131711.15015.bjorn.helgaas@hp.com> <617E1C2C70743745A92448908E030B2A0274F144@scsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:43353 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543AbXISPtu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Sep 2007 11:49:50 -0400
In-Reply-To: <617E1C2C70743745A92448908E030B2A0274F144@scsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday 18 September 2007 05:53:28 pm Luck, Tony wrote:
> > If you don't object to the two patches, can you incorporate them
> > as originally posted?  If you'd prefer a different approach, I'd
> > be happy to rework them, of course.
> 
> I think that adding 4K to the kernel (about 0.04% increase looking
> at a recent build ... or 0.0001% of total memory on a 4G system) isn't
> really a big deal.  I'd rather do that than export all the fw_call_*()
> functions for all the world to see.

That's certainly the most straightforward solution.  I'll post those
patches in a bit.

Bjorn
