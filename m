From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch] ACPI: stop complaints about interrupt link End Tags and
 blank IRQ descriptors
Date: Thu, 17 Jul 2008 14:41:28 +0200
Message-ID: <487F3DF8.60305@firstfloor.org>
References: <200807150942.57756.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:59590 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbYGQMld (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 08:41:33 -0400
In-Reply-To: <200807150942.57756.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Gabriele Trombetti <g.trombetti.lkrnl1213@logicschema.com>, yakui.zhao@intel.com

Bjorn Helgaas wrote:
> Silently ignore _PRS End Tags.  We already ignore Start Dependent Functions in
> _PRS, and we already ignore End Tags in _CRS, so we might as well ignore End
> Tags in _PRS as well.
> 
> Silently ignore _PRS IRQ descriptors that mention no interrupts.  The spec
> allows this (section 6.4.2.1 in ACPI 3.0b spec), and it probably means the
> interrupt link can't be configured at all.
> 
> This patch doesn't change any functional behavior; it just removes confusing
> complaints like these:
> 
>     ACPI: Blank IRQ resource
>     ACPI: Resource is not an IRQ entry
> 
> when parsing _PRS data "23 00 00 18 79 00" from an IBM xSeries 335 dual
> Pentium IV Xeon 2.40 GHz machine.  For more details, see
>     http://bugzilla.kernel.org/show_bug.cgi?id=11049
> 
> The "23 00 00 18" part is a three-byte-long small IRQ resource with no bits set
> in the IRQ mask ("00 00"), and level-triggered, active low, shareable ("18").
> 
> The "79 00" is an End Tag (type 0x7).  It is superfluous since there is no
> Start Dependent Function tag and there are no resources after it, but it is
> harmless.
> 
> Thanks to Gabriele Trombetti <g.trombetti.lkrnl1213@logicschema.com>
> (aka Kurk) for reporting this and testing the patch.

Looks good, thanks.

-Andi
