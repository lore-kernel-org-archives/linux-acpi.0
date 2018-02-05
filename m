From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Mon, 5 Feb 2018 22:55:17 +0100
Message-ID: <20180205225517.4c565351@endymion>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
        <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
        <20180205141447.6e1442ac@endymion>
        <ddcf31de6764453e98fb8647514ad8fa@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbeBEVzU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Feb 2018 16:55:20 -0500
In-Reply-To: <ddcf31de6764453e98fb8647514ad8fa@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: alex.hung@canonical.com, rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, f.fainelli@gmail.com, dmitry.torokhov@gmail.com, kishon@ti.com, karniksayli1995@gmail.com, linux-acpi@vger.kernel.org

On Mon, 5 Feb 2018 17:24:43 +0000, Mario.Limonciello@dell.com wrote:
> > > +static int __init dmi_oem_osi_add(const struct dmi_system_id *d)
> > > +{
> > > +	struct acpi_osi_entry *osi;
> > > +	const char *str = d->driver_data;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
> > > +		osi = &osi_setup_entries[i];
> > > +		if (!strcmp(osi->string, str)) {  
> > 
> > This can only happen if the user passes acpi_osi=Linux-Dell-Video or
> > acpi_osi=!Linux-Dell-Video on the boot command line, right?
> >   
> > > +			osi->enable = true;  
> > 
> > Does this not prevent the user from explicitly disabling it with
> > acpi_osi=!Linux-Dell-Video ?
> >   
> > > +			continue;  
> > 
> > Are you not done at this point? I think you want to break, not
> > continue, else you may add a duplicate Linux-Dell-Video entry below.  
> 
> You might have two different entries that apply to the same system in the future.
> 
> At least the way that Dell is intending to use this is that "Linux-Dell-Video" would
> only apply to ASL related to video configuration.
> 
> If for example there is later an issue with audio on a different platform that also
> needed "Linux-Dell-Video", the ASL to do the audio configuration would be activated
> by "Linux-Dell-Audio".

I understand what you say, but can't see how this relates to my
concerns above.

-- 
Jean Delvare
SUSE L3 Support
