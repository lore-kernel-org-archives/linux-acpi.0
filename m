From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware doesn't define one
Date: Thu, 15 May 2008 02:04:26 +0100
Message-ID: <20080515010426.GA13927@srcf.ucam.org>
References: <20080514010000.GB21608@srcf.ucam.org> <20080514010300.GC21608@srcf.ucam.org> <20080514010820.GD21608@srcf.ucam.org> <200805132330.20159.lenb@kernel.org> <20080514093304.GB28678@srcf.ucam.org> <1210812916.2929.6.camel@rzhang-crestline.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47148 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbYEOBEw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 21:04:52 -0400
Content-Disposition: inline
In-Reply-To: <1210812916.2929.6.camel@rzhang-crestline.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thu, May 15, 2008 at 08:55:16AM +0800, Zhang Rui wrote:

> Menlow also defines ACPI thermal zones and all these thermal zones are
> registered with the generic thermal class.
> The difference is that menlow uses _TZD to list many other devices for
> throttling, and all these devices are registered with the generic
> thermal class as well.
> If this patch is applied, processors may be throttled unexcepted.

Hm. If there's a TZD defined for the thermal zone, then it makes sense 
to use that rather than using the processor. I didn't bother since I 
haven't yet been able to find a machine that used TZD for anything other 
than the CPU :) I'll implement that tomorrow.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
