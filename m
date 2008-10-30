From: Frans Pop <elendil@planet.nl>
Subject: Re: iasl and SSDT disassembling limitations
Date: Thu, 30 Oct 2008 10:11:36 +0100
Message-ID: <200810301011.37320.elendil@planet.nl>
References: <3515468CA27A0F49917112E2ECF61E210927CBF912@pdsmsx502.ccr.corp.intel.com> <1224845430.14280.58.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml13.KPNXCHANGE.COM ([213.75.38.113]:40842 "EHLO
	hpsmtp-eml13.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753092AbYJ3JLj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Oct 2008 05:11:39 -0400
In-Reply-To: <1224845430.14280.58.camel@minggr.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, hmh@hmh.eng.br

On Friday 24 October 2008, Lin Ming wrote:
> We have added a "-e" option to iasl that include tables for external
> symbol resolution.

Thanks very much. That does indeed give me a correctly disassembled table.

Would it be possible to add a warning when unavailable external symbols 
are detected? The warning could even be made verbose by saying that this 
may result in an incorrect dsl file and refer to the -e option (and maybe 
even specifically mention the dsdt table if that is the source for 
missing symbols in most cases).

Currently there is really no indication at all that something may have 
gone wrong or why until you look at the generated dsl file.

Cheers,
FJP
