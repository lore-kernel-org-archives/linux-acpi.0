From: Luca Capello <luca@pca.it>
Subject: Re: Oops removing thinkpad_acpi and video on git:linux-acpi-2.6
Date: Fri, 02 Nov 2007 15:16:23 +0100
Message-ID: <87d4ushgw8.fsf@gismo.pca.it>
References: <87lka1ffwc.fsf@gismo.pca.it>
 <20071018012106.GA24821@khazad-dum.debian.net> <87tzoo2q3x.fsf@gismo.pca.it>
 <20071018230334.GD4483@khazad-dum.debian.net> <871wbr2u1r.fsf@gismo.pca.it>
 <20071020002720.GA21173@khazad-dum.debian.net> <87myuccqen.fsf@gismo.pca.it>
 <20071022013204.GA13019@khazad-dum.debian.net> <87prz7myq9.fsf@gismo.pca.it>
 <20071022170021.GA30584@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_80RCiPmHgVZGVxcokLfY/g)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mbox.unige.ch ([129.194.9.209]:43453 "EHLO mbox.unige.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370AbXKBOQ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Nov 2007 10:16:27 -0400
Received: from gismo.pca.it ([129.194.56.110])
 by mbox.unige.ch (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9
 2007; 32bit)) with ESMTPSA id <0JQV0072HUBD5500@mbox.unige.ch> for
 linux-acpi@vger.kernel.org; Fri, 02 Nov 2007 15:16:25 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ML Linux-ACPI <linux-acpi@vger.kernel.org>


--Boundary_(ID_80RCiPmHgVZGVxcokLfY/g)
Content-type: TEXT/PLAIN; CHARSET=us-ascii
Content-transfer-encoding: 7BIT

Hi Henrique!

Sorry for the delay, I was busy with real life...

On Mon, 22 Oct 2007 19:00:21 +0200, Henrique de Moraes Holschuh wrote:
> On Mon, 22 Oct 2007, Luca Capello wrote:
> And we *did* unregister all notification functions in thinkpad-acpi,
> so it might well be a problem in the ACPI core, and not
> thinkpad-acpi.

It seems that the oops is no more thinkpad-acpi's fault, since
yesterday and today I got the oops with ACPI's video only (read
below).

> Please try again, this time do this beforehand (warning: will generate a lot
> of debug output):
>
> echo 0x4 > /proc/acpi/debug_layer
> echo 0xfffffff > /proc/acpi/debug_level
>
> Maybe we will be lucky and give us more info on what the ACPI layer
> is calling that causes the oops.

The oops removing ACPI's video module occurred both in 2.6.23.1 (with
thinkpad-acpi-0.18) or today's git pull for linux-acpi-2.6.

The machine booted with both video and thinkpad-acpi, then I removed
them, enabled the ACPI debug and inserted video.  To be sure that the
oops wasn't video-related, I removed the video module and I got the
oops (attached).

I think I don't need 2.6.23.1 anymore, right?

Now, since on Monday I'll bring my laptop to the IBM repairing center
and since they told me that to repair the broken SD card reader
they'll change the whole motherboard, I guess that they'll return me
the laptop with the BIOS upgraded.  So, if any urgent test is needed,
I can perform it during the week-end.

Thx, bye,
Gismo / Luca


--Boundary_(ID_80RCiPmHgVZGVxcokLfY/g)
Content-type: application/octet-stream;
 NAME=dmesg-2.6.24-rc1_linux-acpi-2.6_video-oops_gismo-20071102.log.gz
Content-transfer-encoding: base64
Content-disposition: attachment;
 filename=dmesg-2.6.24-rc1_linux-acpi-2.6_video-oops_gismo-20071102.log.gz
Content-description: removing video oops on linux-acpi-2.6_2.6.24-rc1

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

--Boundary_(ID_80RCiPmHgVZGVxcokLfY/g)--
