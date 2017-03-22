From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 3/3] ACPI: Don't create a platform_device for
 IOAPIC/IOxAPIC
Date: Wed, 22 Mar 2017 23:58:53 +0100
Message-ID: <20170322225853.GH8329@suse.de>
References: <1490204005-2733-1-git-send-email-joro@8bytes.org>
 <1490204005-2733-4-git-send-email-joro@8bytes.org>
 <2232546.0OJbVJtxLm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48147 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753610AbdCVW6O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Mar 2017 18:58:14 -0400
Content-Disposition: inline
In-Reply-To: <2232546.0OJbVJtxLm@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Rafael,

On Wed, Mar 22, 2017 at 06:42:39PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, March 22, 2017 06:33:25 PM Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > No platform-device is required for IO(x)APICs, so don't even
> > create them.
> > 
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> If we do this, I'd prefer not to do [2/3], because we'll introduce code that
> will be essentially dead then.

In this case the code in acpi_bus_attach() adding platform_devices is also
dead. Could it be removed then?

> 
> > ---
> >  drivers/acpi/acpi_platform.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> > index b4c1a6a..03250e1 100644
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -25,9 +25,11 @@
> >  ACPI_MODULE_NAME("platform");
> >  
> >  static const struct acpi_device_id forbidden_id_list[] = {
> > -	{"PNP0000", 0},	/* PIC */
> > -	{"PNP0100", 0},	/* Timer */
> > -	{"PNP0200", 0},	/* AT DMA Controller */
> 
> Why do you change the existing entries?

Just to align the '0's in one column :)


	Joerg

