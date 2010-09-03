From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: acpi_atomic_read() requirements
Date: Fri, 3 Sep 2010 09:00:33 -0600
Message-ID: <201009030900.33581.bjorn.helgaas@hp.com>
References: <201009021934.52861.bjorn.helgaas@hp.com> <201009022232.45290.bjorn.helgaas@hp.com> <20100903111705.3ae78159@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:10964 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab0ICPBC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Sep 2010 11:01:02 -0400
In-Reply-To: <20100903111705.3ae78159@basil.nowhere.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Huang Ying <ying.huang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday, September 03, 2010 03:17:05 am Andi Kleen wrote:
> > Good.  Unless there's a spec requirement for 64-bit accesses in this
> > area, I think it's better to do it the same way as acpi_read(), just
> > so we're as consistent as possible.
> 
> I'm not sure if the spec explicit asks for it, but doing a full
> 64bit access would be in the spirit of it at least.

It would, and I hoped the spec would clarify that, but I didn't
see anything.

If there's a reason to have acpi_atomic_read() work differently
than acpi_read() in this respect, that's fine.  I just don't see
it yet.  If they *can* be made similar in this, I think we might
be able to collapse them into a single, smaller implementation.

> On the other hand I would expect hardware that really requires 64bit
> to be rare because 32bit OS would always have some trouble with
> it.
