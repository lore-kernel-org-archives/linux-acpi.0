From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 3 Jul 2008 23:29:27 +0100
Message-ID: <20080703222927.GA2701@srcf.ucam.org>
References: <200807031809.03172.trenn@suse.de> <20080703162152.GC29110@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080703162152.GC29110@srcf.ucam.org>
Sender: linux-next-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 03, 2008 at 05:21:52PM +0100, Matthew Garrett wrote:
> On Thu, Jul 03, 2008 at 06:08:59PM +0200, Thomas Renninger wrote:
> 
> > +	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "DRDY", &h_dummy))) {
> > +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IGD device\n"));
> > +		video_caps |= ACPI_VIDEO_IGD;
> > +	}
> 
> In principle, it's possible for a vendor to implement opregion but not 
> actually use it until the tche flags are set. If anyone's done that then 
> you've just broken backlight control on their system.

I've just had it confirmed that recent Panasonics behave this way. I 
suspect the same's true of many 965 systems.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
