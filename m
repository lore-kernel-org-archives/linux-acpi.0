From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [PATCH 2/2] RFC: ACPI: Set enforce_resources to strict if a
	ATK0110 device is found in namespace
Date: Mon, 2 Feb 2009 21:29:07 +0100
Message-ID: <20090202202907.GA9223@dreamland.darkstar.lan>
References: <20090125210520.GA12963@dreamland.darkstar.lan> <20090202101103.1208c035@hyperion.delvare> <68676e00902020338o7326ff7dx4efadf94ed534acf@mail.gmail.com> <200902021822.20237.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f12.google.com ([209.85.218.12]:51968 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbZBBU3z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Feb 2009 15:29:55 -0500
Content-Disposition: inline
In-Reply-To: <200902021822.20237.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>

Il Mon, Feb 02, 2009 at 06:22:19PM +0100, Thomas Renninger ha scritto: 
> On Monday 02 February 2009 12:38:24 you wrote:
> > On Mon, Feb 2, 2009 at 10:11 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > > On Sun, 1 Feb 2009 22:22:43 +0100, Luca Tettamanti wrote:
> > >> --- a/drivers/acpi/osl.c
> > >> +++ b/drivers/acpi/osl.c
> > >> @@ -1063,7 +1063,10 @@ __setup("acpi_wake_gpes_always_on",
> > >> acpi_wake_gpes_always_on_setup); * in arbitrary AML code and can
> > >> interfere with legacy drivers. * acpi_enforce_resources= can be set to:
> > >>   *
> > >> - *   - strict           (2)
> > >> + *   - auto             (2)
> > >> + *     -> detect possible conflicts with ACPI drivers and switch to
> > >> + *     strict if needed, otherwise act like lax
> > >> + *   - strict           (3)
> > >>   *     -> further driver trying to access the resources will not load
> > >>   *   - lax (default)    (1)
> > >>   *     -> further driver trying to access the resources will load, but
> > >> you @@ -1073,11 +1076,12 @@ __setup("acpi_wake_gpes_always_on",
> > >> acpi_wake_gpes_always_on_setup); *     -> ACPI Operation Region
> > >> resources will not be registered *
> > >>   */
> > >> -#define ENFORCE_RESOURCES_STRICT 2
> > >> +#define ENFORCE_RESOURCES_STRICT 3
> > >> +#define ENFORCE_RESOURCES_AUTO   2
> > >>  #define ENFORCE_RESOURCES_LAX    1
> > >>  #define ENFORCE_RESOURCES_NO     0
> > >
> > > I don't see any reason to change ENFORCE_RESOURCES_STRICT from 2 to 3.
> > > Just add ENFORCE_RESOURCES_AUTO as 3 and that's it, makes your patch
> > > smaller.
> >
> > There's an unspoken reason ;-) The options are ordered by
> > "strictness", I was experimenting with an API to export the parameter,
> > in order to move the code to a separate quirk file. Since it's not
> > relevant in this patch I'll back out the change.
> 
> And the other one, implementing the ATK0110 quirk.
> The same probably could be easy done now with video_detect.c.
> The video device HID should get added in scan.c again as suggested by Bjorn.
> Then the video_detect.c can go into quirks.c and get deleted.
> 
> What do you think?

Well mostly ACK, modulo DMI comment in my other email.

> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 6729a49..92e4226 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
[...]
> -static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
> +unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_AUTO;
>  
>  static int __init acpi_enforce_resources_setup(char *str)
>  {

You're missing the code to parse "auto" here.

I also have this patch from a previous email:

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index d8362cf..10fd2d7 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -258,6 +258,25 @@ and is between 256 and 4096 characters. It is defined in the file
 			to assume that this machine's pmtimer latches its value
 			and always returns good values.
 
+	acpi_enforce_resources=	[ACPI]
+			{ strict, auto, lax, no }
+			Check for resource conflicts between native drivers
+			and ACPI OperationRegions (SystemIO and SystemMemory
+			only). IO ports and memory declared in ACPI might be
+			used by the ACPI subsystem in arbitrary AML code and
+			can interfere with legacy drivers.
+			strict: access to resources claimed by ACPI is denied;
+			legacy drivers trying to access reserved resources
+			will fail to load.
+			auto (default): try and detect ACPI devices with known
+			ACPI drivers; escalates the setting to "strict" if such
+			a device is found, otherwise behaves like "lax".
+			lax: access to resources claimed by ACPI is allowed;
+			legacy drivers trying to access reserved resources
+			will load and a warning message is logged.
+			no: ACPI OperationRegions are not marked as reserved,
+			no further checks are performed.
+
 	agp=		[AGP]
 			{ off | try_unsupported }
 			off: disable AGP support

Luca
-- 
"L'amore consiste nell'essere cretini insieme." -- P. Valery
