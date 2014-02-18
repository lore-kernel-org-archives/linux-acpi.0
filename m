From: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Subject: Re: [PATCH v4] ACPI / video: Add systems that should favour native
 backlight interface
Date: Tue, 18 Feb 2014 23:28:29 +0400
Message-ID: <1392751709.4640.371.camel@X1Carbon.localdomain>
References: <5302F58C.1080001@intel.com> <20140218103442.GS5018@intel.com>
	 <s5hfvngy2bh.wl%tiwai@suse.de> <1903167.TtlOFgMB6X@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:57504 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbaBRT2g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Feb 2014 14:28:36 -0500
In-Reply-To: <1903167.TtlOFgMB6X@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Takashi Iwai <tiwai@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Theodore Tso <tytso@mit.edu>, Peter Weber <bugs@ttyhoney.com>, Lennart Poettering <lennart@poettering.net>, Kevin Smith <thirdwiggin@gmail.com>, Rinat Ibragimov <ibragimovrinat@mail.ru>, sov.info@mail.ru, Thomas Christensen <christensenthomas@gmail.com>, Vladimir Sherenkov <a_12300@mail.ru>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>

On Tue, 2014-02-18 at 16:22 +0100, Rafael J. Wysocki wrote: 
> On Tuesday, February 18, 2014 02:31:46 PM Takashi Iwai wrote:
> > At Tue, 18 Feb 2014 12:34:42 +0200,
> > Mika Westerberg wrote:
> > > 
> > > On Tue, Feb 18, 2014 at 01:54:20PM +0800, Aaron Lu wrote:
> > > > +	{
> > > > +	.callback = video_set_use_native_backlight,
> > > > +	.ident = "HP EliteBook 2013 models",
> > > > +	.matches = {
> > > > +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> > > > +		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook "),
> > > > +		DMI_MATCH(DMI_PRODUCT_NAME, " G1"),
> > > > +		},
> > > > +	},
> > > 
> > > I see my device is listed here but the above doesn't really use native
> > > backlight because it is still in acpi_osi blacklist. Tried this and I can
> > > see both acpi_video0 and intel_backlight listed under /sys/class/backlight.
> > > Was this the intention?
> > 
> > The acpi_osi blacklist commit (2d4054d84224) has to be reverted, as I
> > mentioned earlier.  But the revert can be done individually after
> > merging this patch.  Rafael, could you care?
> 
> Done.  Please check the result in linux-pm.git/linux-next.
Is it will merge to 3.14 ?

P.S. why you don't using rafael@ mail ? *joke* 
> 
> Thanks,
> Rafael
> 


-- 
-Igor Gnatenko

