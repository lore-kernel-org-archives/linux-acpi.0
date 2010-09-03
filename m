From: Andi Kleen <andi@firstfloor.org>
Subject: Re: acpi_atomic_read() requirements
Date: Fri, 3 Sep 2010 11:17:05 +0200
Message-ID: <20100903111705.3ae78159@basil.nowhere.org>
References: <201009021934.52861.bjorn.helgaas@hp.com>
	<1283478599.13175.91.camel@yhuang-dev>
	<201009022232.45290.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:36900 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560Ab0ICJRS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Sep 2010 05:17:18 -0400
In-Reply-To: <201009022232.45290.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Huang Ying <ying.huang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


> 
> Good.  Unless there's a spec requirement for 64-bit accesses in this
> area, I think it's better to do it the same way as acpi_read(), just
> so we're as consistent as possible.

I'm not sure if the spec explicit asks for it, but doing a full
64bit access would be in the spirit of it at least.

On the other hand I would expect hardware that really requires 64bit
to be rare because 32bit OS would always have some trouble with
it.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
