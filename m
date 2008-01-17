From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [PATCH] Enable _OSI(Linux) for Xen HVM domains
Date: Thu, 17 Jan 2008 15:15:37 -0700
Message-ID: <1200608137.7657.85.camel@bling>
References: <1194375906.31834.211.camel@bling>
	 <200801161944.48250.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:30742 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759399AbYAQWQA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 17:16:00 -0500
In-Reply-To: <200801161944.48250.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Keir Fraser <keir@xensource.com>


On Wed, 2008-01-16 at 19:44 -0500, Len Brown wrote: 
> 
> I think it is fine for the "BIOS" to use the OSI mechanism to ask about the OS.
> However, the string "Linux" is probably not a good choice for the string.
> 
> The reason we deleted OSI(Linux) by default is because it is ill-defined.
> A good OSI string would be much more specific, ie. label something
> that is well defined, or at least include version information.
> 
> eg. "ACPI 3.0 Thermal Model" means that an OS implements the
> ACPI 3.0 extensions to the thermal model (which we don't, BTW).

Hi Len,

   Thanks for the extra explanation.  For now, we've decided to go a
different route and create a domain configuration option, so we can do
without this patch.  Thanks,

	Alex

-- 
Alex Williamson                             HP Open Source & Linux Org.

