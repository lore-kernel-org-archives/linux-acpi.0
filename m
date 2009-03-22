From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 08:10:30 +0900
Message-ID: <20090322231029.GC17905@kamineko.org>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:36784
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590AbZCVXKe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Mar 2009 19:10:34 -0400
Content-Disposition: inline
In-Reply-To: <20090322224652.GA13814@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Norbert Preining <preining@logic.at>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Sun, Mar 22, 2009 at 10:46:52PM +0000, Matthew Garrett wrote:
> On Sun, Mar 22, 2009 at 11:06:55PM +0100, Norbert Preining wrote:
> 
> > BUT:
> > - suddenly the sony-laptop module is convinced that the *hardware*
> >   rfkill switch is always turned on, always. Not even reloading an older
> >   sony-laptop helped. Rebooting neither. Shutting down and rebooting
> >   with an older sony-laptop as default made wifi show up again.
> >   I am not sure if cold booting into the latest version of your patch
> >   will work, haven't tried till now, sorry, will do tomorrow.
> 
> Hmm. Don't /think/ I did anything that should affect that, but it's 
> possible. If it's reproducable, can you try commenting out the 
> sony_call_snc_handle calls in sony_nc_function_setup and see if they 
> change the behaviour? You'll probably need to reboot in between.
> 
> > - S1 and S2 do adjustment of the brightness, while Fn-F5 and Fn-F6 do
> >   not do anything, but this is probably only configuration stuff.
> 
> Ok, sounds like the mapping needs to be changed. Can you let me know 
> which ACPI events are generated for each key?

Yes it does.
A vaio SR user sent me this list for 0x9c that after a call to SN07(202)
becomes:

+       { 0x81, SONYPI_EVENT_MODEKEY_PRESSED },
+       { 0x01, SONYPI_EVENT_ANYBUTTON_RELEASED },
+       { 0x82, SONYPI_EVENT_PKEY_P1 },
+       { 0x02, SONYPI_EVENT_ANYBUTTON_RELEASED },
+       { 0x83, SONYPI_EVENT_PKEY_P2 },
+       { 0x03, SONYPI_EVENT_ANYBUTTON_RELEASED },
+       { 0x84, SONYPI_EVENT_PKEY_P3 },
+       { 0x04, SONYPI_EVENT_ANYBUTTON_RELEASED },
+       { 0x85, SONYPI_EVENT_PKEY_P4 },
+       { 0x05, SONYPI_EVENT_ANYBUTTON_RELEASED },
+       { 0x86, SONYPI_EVENT_PKEY_P5 },
+       { 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
+       { 0x87, SONYPI_EVENT_SETTINGKEY_PRESSED },
+       { 0x07, SONYPI_EVENT_ANYBUTTON_RELEASED },
+       { 0, 0 },

-- 
mattia
:wq!
