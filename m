From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight handler if
	ACPI generic could do it
Date: Tue, 09 Oct 2007 15:29:12 +0200
Message-ID: <1191936552.9847.257.camel@queen.suse.de>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br>
	 <1191849179-24087-4-git-send-email-hmh@hmh.eng.br>
	 <1191910875.9847.79.camel@queen.suse.de>
	 <20071009075914.GA790@srcf.ucam.org>
	 <1191918351.9847.132.camel@queen.suse.de>
	 <20071009083336.GA1099@srcf.ucam.org>
	 <1191923208.9847.169.camel@queen.suse.de>
	 <20071009100418.GA2472@srcf.ucam.org>
	 <20071009111445.GB24946@khazad-dum.debian.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40644 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbXJIN3U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2007 09:29:20 -0400
In-Reply-To: <20071009111445.GB24946@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, 2007-10-09 at 08:14 -0300, Henrique de Moraes Holschuh wrote:
> On Tue, 09 Oct 2007, Matthew Garrett wrote:
> > On Tue, Oct 09, 2007 at 11:46:48AM +0200, Thomas Renninger wrote:
> > 
> > > More important: CONFIG_THINKPAD_ACPI_BACKLIGHT_DESIRED variable is error
> > > prone and should not get introduced, right?
> 
> Error prone how?  Please expand, because right now I am not inclined to
> remove that variable.  It is optional, and disabled by default.  Distros are
> not going to enable it unless they have a damn good reason to, and it is not
> even something that one can enable at runtime.
> 
> Should I make the help text stronger against enabling the option? Is it not
> clear enough?
No, all the _BCL poking should vanish.

Fn keys brightness control shouldn't work on any latest thinkpad with
this code. As soon as you invoke _BCL a flag gets set in AML code and
later the AML code (search somewhere in the _QXX functions) checks that
flag and will send a notify to LCD0 (0x86/0x87) and relies on the OS to
lower/increase the brightness through _BCM.

> If you look at the patch, you will notice that the backlight changes are
> small, and the biggest part of them affects __init code, which I make
> exactly *zero* effort to optimize for size: it is basically "free" for the
> scenarios I have to bother with (thinkpads).
>
> > backlight functionality if it can be controlled through the standard 
> > mechanism instead.
> 
> Well, it is a simple matter of removing the Kconfig option and making that
> code non-optional.  But I am not adding a remove-video-support Kconfig
> option at this time.  It will wait until I break the driver down into
> multiple modules.

My suggestion:
static int force_brightness;
module_param(force_brightness, bool, 0);

static int do_not_use_brightness;

static dummy_vid_add(struct acpi_device *device){
	do_not_use_brightness = 1;
	return -EINVAL;
}

static const struct acpi_device_id dummy_vid_device_ids[] = {
	{"LNXVIDEO", 0},
	{"", 0},
};
static struct acpi_driver dummy_vid_driver = {
	.ids = dummy_vid_device_ids,
	.ops = {
		.add = dummy_vid_add,
         }
}

static int __init brightness_init(struct ibm_init_struct *iibm)
{
	if (do_not_use_brightness)
		return -EINVAL;
...
}
...
if (!force_brightness){
	acpi_bus_register_driver(&acpi_dummy_vid_driver);
}

I am a bit anxious with letting two drivers match against "LNXVIDEO",
but I don't know why this should not work. Like that the same code
whether video can register or not is processed and you can be sure
whether video should get active or not.
If the double register does not work, a global variable in
drivers/acpi/scan.c here should do it:
		if(!(info->valid & (ACPI_VALID_HID | ACPI_VALID_CID))){
			status = acpi_video_bus_match(device);
			if(ACPI_SUCCESS(status))
				hid = ACPI_VIDEO_HID;

like that we can be sure (also against modifications at this one place)
video will load.
Hmm, maybe the acpi_video_bus_match test should get extended to match
either against the already tested functions or _BCM/_BCL and maybe only
set the variable if brightness funcs are there.
I'd prefer such a test to avoid the walknamespace call but mainly to
have the matching whether video should be used at one central place.

Also a module parameter to force brightness at module load time should
be more convenient for letting people try out both. I don't see the need
for an extra config variable.

    Thomas

