From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 3/5 -v2] acpi, apei, HEST table parsing
Date: Thu, 24 Dec 2009 16:59:10 +0800
Message-ID: <1261645150.6908.28.camel@yhuang-dev.sh.intel.com>
References: <1260429419.15264.395.camel@yhuang-dev.sh.intel.com>
	 <20091218184443.GD1470@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:20269 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693AbZLXI7M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Dec 2009 03:59:12 -0500
In-Reply-To: <20091218184443.GD1470@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Sat, 2009-12-19 at 02:44 +0800, Pavel Machek wrote: 
> On Thu 2009-12-10 15:16:59, Huang Ying wrote:
> > HEST describes error sources in detail; communicating operational
> > parameters (i.e. severity levels, masking bits, and threshold values)
> > to OS as necessary. It also allows the platform to report error
> > sources for which OS would typically not implement support (for
> > example, chipset-specific error registers).
> > 
> > HEST information may be needed by other subsystems. For example, HEST
> > PCIE AER error source information describes whether a PCIE root port
> > works in "firmware first" mode, this is needed by general PCIE AER
> > error subsystem. So a public HEST tabling parsing interface is
> > provided.
> 
> Perhaps you can remove unused hest_exit()?

OK. I will remove it.

Best Regards,
Huang Ying


