From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: iasl and SSDT disassembling limitations
Date: Thu, 30 Oct 2008 17:16:50 +0800
Message-ID: <1225358210.4477.52.camel@minggr.sh.intel.com>
References: <3515468CA27A0F49917112E2ECF61E210927CBF912@pdsmsx502.ccr.corp.intel.com>
	 <1224845430.14280.58.camel@minggr.sh.intel.com>
	 <200810301011.37320.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:39294 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbYJ3JTD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Oct 2008 05:19:03 -0400
In-Reply-To: <200810301011.37320.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "hmh@hmh.eng.br" <hmh@hmh.eng.br>, "Moore, Robert" <robert.moore@intel.com>

On Thu, 2008-10-30 at 17:11 +0800, Frans Pop wrote:
> On Friday 24 October 2008, Lin Ming wrote:
> > We have added a "-e" option to iasl that include tables for external
> > symbol resolution.
> 
> Thanks very much. That does indeed give me a correctly disassembled table.
> 
> Would it be possible to add a warning when unavailable external symbols 
> are detected? The warning could even be made verbose by saying that this 
> may result in an incorrect dsl file and refer to the -e option (and maybe 
> even specifically mention the dsdt table if that is the source for 
> missing symbols in most cases).

Good idea. Yes, we are going to add this warning message.

Lin Ming

> 
> Currently there is really no indication at all that something may have 
> gone wrong or why until you look at the generated dsl file.
> 
> Cheers,
> FJP

