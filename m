From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 3/3] mce, acpi/apei: Soft-offline a page on firmware
 GHES notification
Date: Wed, 10 Jul 2013 11:38:44 +0200
Message-ID: <20130710093844.GD14873@pd.tnic>
References: <CA+8MBbKU-YHrVvV6uxE2gJ8Ko=06o=_y90peUBsC4SvOXMLO_w@mail.gmail.com>
 <20130710092225.20744.63823.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33555 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059Ab3GJJjA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jul 2013 05:39:00 -0400
Content-Disposition: inline
In-Reply-To: <20130710092225.20744.63823.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On Wed, Jul 10, 2013 at 02:57:01PM +0530, Naveen N. Rao wrote:
> On 07/09/2013 12:30 AM, Tony Luck wrote:
> > I was off on vacation last week - looks like you got lots done without me
> > :-)
> > 
> > I have parts 1 & 2 applied to an internal tree. Looks like parts 3 & 4 need
> > a few final polishes to get an Ack from Boris.
> 
> Cool :)
> Here is the updated patch for part 3 incorporating Boris's comments.
> 
> Thanks,
> Naveen
> --
> 
> If the firmware indicates in GHES error data entry that the error threshold
> has exceeded for a corrected error event, then we try to soft-offline the
> page. This could be called in interrupt context, so we queue this up similar
> to how we handle memory failure scenarios.
> 
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Borislav Petkov <bp@suse.de>

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
