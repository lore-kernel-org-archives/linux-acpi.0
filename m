From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware
	doesn't define one
Date: Thu, 15 May 2008 08:55:16 +0800
Message-ID: <1210812916.2929.6.camel@rzhang-crestline.sh.intel.com>
References: <20080514010000.GB21608@srcf.ucam.org>
	 <20080514010300.GC21608@srcf.ucam.org>
	 <20080514010820.GD21608@srcf.ucam.org> <200805132330.20159.lenb@kernel.org>
	 <20080514093304.GB28678@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2289 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbYEOAzL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 20:55:11 -0400
In-Reply-To: <20080514093304.GB28678@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org


On Wed, 2008-05-14 at 10:33 +0100, Matthew Garrett wrote:
> On Tue, May 13, 2008 at 11:30:20PM -0400, Len Brown wrote:
> 
> > An entire new handheld product line will ship this year
> > where the assumption that the processor is the primary
> > contributor to heat may simply be _false_, thermal
> > zones may be totally unrelated to the processor,
> > and throttling the processor may be exactly the
> > wrong way to handle a thermal issue.
> 
> That's fine. In the ACPI code, we currently have no support for managing 
> thermal conditions through anything other than the processor. Once that 
> changes, it's easy to fix this up so it doesn't interfere with thermal 
> zones that are handled by throttling other devices.
> 
> Menlow has a more complex thermal model than machines we've seen up to 
> now, but I was under the impression that this was to be handled by the 
> new generic thermal class rather than the existing ACPI code. I don't 
> see this patch as being in conflict with supporting that.
> 
Menlow also defines ACPI thermal zones and all these thermal zones are
registered with the generic thermal class.
The difference is that menlow uses _TZD to list many other devices for
throttling, and all these devices are registered with the generic
thermal class as well.
If this patch is applied, processors may be throttled unexcepted.

thanks,
rui

