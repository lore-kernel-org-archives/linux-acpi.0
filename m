From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight handler if
	ACPI generic could do it
Date: Tue, 9 Oct 2007 10:47:11 -0300
Message-ID: <20071009134711.GA444@khazad-dum.debian.net>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br> <1191849179-24087-4-git-send-email-hmh@hmh.eng.br> <1191910875.9847.79.camel@queen.suse.de> <20071009075914.GA790@srcf.ucam.org> <1191918351.9847.132.camel@queen.suse.de> <20071009083336.GA1099@srcf.ucam.org> <1191923208.9847.169.camel@queen.suse.de> <20071009100418.GA2472@srcf.ucam.org> <20071009111445.GB24946@khazad-dum.debian.net> <1191936552.9847.257.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39306 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751977AbXJINrT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2007 09:47:19 -0400
Content-Disposition: inline
In-Reply-To: <1191936552.9847.257.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, 09 Oct 2007, Thomas Renninger wrote:
> > Error prone how?  Please expand, because right now I am not inclined to
> > remove that variable.  It is optional, and disabled by default.  Distros are
> > not going to enable it unless they have a damn good reason to, and it is not
> > even something that one can enable at runtime.
> > 
> > Should I make the help text stronger against enabling the option? Is it not
> > clear enough?
>
> No, all the _BCL poking should vanish.

I need to *somehow* find out if the thinkpad supports the video extensions.

> Fn keys brightness control shouldn't work on any latest thinkpad with
> this code. As soon as you invoke _BCL a flag gets set in AML code and
> later the AML code (search somewhere in the _QXX functions) checks that
> flag and will send a notify to LCD0 (0x86/0x87) and relies on the OS to
> lower/increase the brightness through _BCM.

Hmm, to just disable backlight (no checking for levels), I can just check
the existence of _BCL (or _BCM, or _BQC) instead of invoking it.

But even if I want to know how many levels, there is a way. I can locate and
retrieve the BCLL package, and count how many items there are in it.  So it
still doesn't kill the possibility of supporting 16 levels.  So the question
about the Kconfig option is still open.

But I am far more inclined to just drop it, now.

Thanks for the head's up about the _BCL interation, btw.  None of the
testers pointed that problem.  Ugly crap, that one.  There is _DOS for the
OS to tell the AML code what it should do with the notifications, I wish
Lenovo didn't add so many weird work-arounds in their AML SDTs, it cause more
problems than not.

> My suggestion:
> static int force_brightness;
> module_param(force_brightness, bool, 0);
> 
> static int do_not_use_brightness;
> 
> static dummy_vid_add(struct acpi_device *device){
> 	do_not_use_brightness = 1;
> 	return -EINVAL;
> }
> 
> static const struct acpi_device_id dummy_vid_device_ids[] = {
> 	{"LNXVIDEO", 0},
> 	{"", 0},
> };
> static struct acpi_driver dummy_vid_driver = {
> 	.ids = dummy_vid_device_ids,
> 	.ops = {
> 		.add = dummy_vid_add,
>          }
> }
> 
> static int __init brightness_init(struct ibm_init_struct *iibm)
> {
> 	if (do_not_use_brightness)
> 		return -EINVAL;
> ...
> }
> ...
> if (!force_brightness){
> 	acpi_bus_register_driver(&acpi_dummy_vid_driver);
> }

What happens if thinkpad-acpi is loaded before the video driver?

> I am a bit anxious with letting two drivers match against "LNXVIDEO",
> but I don't know why this should not work. Like that the same code
> whether video can register or not is processed and you can be sure
> whether video should get active or not.
> If the double register does not work, a global variable in
> drivers/acpi/scan.c here should do it:
> 		if(!(info->valid & (ACPI_VALID_HID | ACPI_VALID_CID))){
> 			status = acpi_video_bus_match(device);
> 			if(ACPI_SUCCESS(status))
> 				hid = ACPI_VIDEO_HID;
> 
> like that we can be sure (also against modifications at this one place)
> video will load.
> Hmm, maybe the acpi_video_bus_match test should get extended to match
> either against the already tested functions or _BCM/_BCL and maybe only
> set the variable if brightness funcs are there.
> I'd prefer such a test to avoid the walknamespace call but mainly to
> have the matching whether video should be used at one central place.

*if* you give me a place to check, which doesn't make thinkpad-acpi depend
on video.c, I will take it, yes.

> Also a module parameter to force brightness at module load time should
> be more convenient for letting people try out both. I don't see the need
> for an extra config variable.

I don't like to add runtime/load-time parameters for stuff that is
deprecated behaviour.  I only do it to support the roll in of a new
interface.  And using backlight from thinkpad-acpi in a thinkpad where
video.c works fine *is* deprecated behaviour (although I didn't say that
anywhere explictly, yet).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
