From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Thu, 13 Nov 2008 01:32:59 +0000
Message-ID: <20081113013259.GA24790@srcf.ucam.org>
References: <200811081637.45099.arvidjaar@mail.ru> <alpine.LFD.2.00.0811111331140.4480@localhost.localdomain> <200811121741.36296.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53344 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbYKMBdF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 20:33:05 -0500
Content-Disposition: inline
In-Reply-To: <200811121741.36296.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org

On Wed, Nov 12, 2008 at 05:41:35PM -0600, Thomas Renninger wrote:
> On Tuesday 11 November 2008 02:04:15 pm Len Brown wrote:
> > so when i apply this patch, i get fewer brightness levels.
> > I prefer to have all 8 brightness levels.
> 
> The patch from Andrey is correct.
> Looks like all, the ordinary user needs, and probably the way it works on a  
> plain Vista OS is there: off, battery, full level.
> You can still use the boot param for your specific needs:
> acpi_display_output=vendor

The Toshiba BIOSes I've looked at all implement the ACPI code on top of 
the legacy interface. Do you have examples where that's not the case? If 
not, I don't see the harm in exposing both.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
