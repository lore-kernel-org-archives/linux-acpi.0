From: Norbert Preining <preining@logic.at>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Tue, 28 Oct 2008 00:20:51 +0100
Message-ID: <20081027232051.GI22083@gamma.logic.tuwien.ac.at>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at> <Pine.LNX.4.63.0810251854180.10973@dashnine.joshuawise.com> <20081025233118.GA31722@gandalf.dynalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:36462 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYJ0XU4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2008 19:20:56 -0400
Content-Disposition: inline
In-Reply-To: <20081025233118.GA31722@gandalf.dynalias.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joshua Wise <joshua@joshuawise.com>
Cc: malattia@linux.it, drzeus-mmc@drzeus.cx, linux-acpi@vger.kernel.org

Hi Joshua, hi all,

On So, 26 Okt 2008, Norbert Preining wrote:
> > 'wwan-power' file somewhere in /sys -- try echoing '1' to it?  Other than
> 
> You mean
> 	/sys/devices/platform/sony-laptop/wwanpower
> ?

That doesn't work. I tried it again. Going the
"first-boot-Vista-and-then-reboot-to-linux" way it does, without the
Vista route echo-ing 1 does not do anything.

> > wake up the modem, I believe you need to send the command 'AT+CFUN=1' to
> > actually put it in 'connect to the network' state, as opposed to the default
> > 'transceiver off'.
> 
> That should go to /dev/ttyUSBsomething I suppose?

No, I guess ttyHS4, the Modem interface of the usb device, right?

> > That works only if in Intel mode; use smartdimmer in nVidia mode.
> 
> I never got it working, and I am always running in intel = stamina mode.
> Nothing whatever I do changes the brightness of the screen. Neither
> using 
> 	/sys/devices/virtual/backlight/sony/brightness
> nor 
> 	/sys/devices/virtual/backlight/acpi_video0/brightness

Running in Intel mode, no changes what-so-ever in brightness.

Mattia, are you listening? Do you have any idea what might go wrong
here?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
AASLEAGH (n.)
A liqueur made only for drinking at the end of a revoltingly long
bottle party when all the drinkable drink has been drunk.
			--- Douglas Adams, The Meaning of Liff
