From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Wed, 9 Jul 2008 16:49:49 +0200
Message-ID: <200807091649.52605.trenn@suse.de>
References: <200807031809.03172.trenn@suse.de> <20080703162152.GC29110@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080703162152.GC29110@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>, Hong Liu <hong.liu@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday 03 July 2008 18:21:52 Matthew Garrett wrote:
> On Thu, Jul 03, 2008 at 06:08:59PM +0200, Thomas Renninger wrote:
> > +	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "DRDY", &h_dummy))) {
> > +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IGD device\n"));
> > +		video_caps |= ACPI_VIDEO_IGD;
> > +	}
>
> In principle, it's possible for a vendor to implement opregion but not
> actually use it until the tche flags are set. If anyone's done that then
> you've just broken backlight control on their system.

Who should set that flags?
The dri driver is going to set that if he can serve IGD parts, right?
I am going to figure out whether your DRI parts, video.ko only or vendor 
specific acpi drivers are going to serve backlight switching.

Currently this patch makes the vendor specific e.g. thinkpad_acpi to serve 
backlight brightness switching if a IGD device is found. Because currently 
there is no IGD support in the kernel.

What is needed is code that runs before module load time and checks for BIOS 
support and then decides whether video.ko or thinkpad_acpi, sony_acpi, 
whatever_can_do_backlight.ko is going to do it. This is in fact what this 
whole patch is about.

You should export a function intel_opregion_init()? so that built in kernel 
parts can check for IGD backlight support, instead of the lines above (part 
of my patch). If this succeeds, my patch will tell vendor specfic drivers to 
keep fingers off backlight switching.

In the dri parts you directly map to the memory instead of using ACPI Field 
names. While a specification might state that the ACPI name should be TCHE, 
it should be checked before module load time the same way as you do it in the 
dri parts.


    Thomas
