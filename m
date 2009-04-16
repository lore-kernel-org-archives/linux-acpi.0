From: Norbert Preining <preining@logic.at>
Subject: Re: gnome-power-manager: adjusting brightness kills AltGr key behaviour
Date: Thu, 16 Apr 2009 14:21:22 +0200
Message-ID: <20090416122122.GC23107@gamma.logic.tuwien.ac.at>
References: <20090416115641.GA15237@gandalf.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:42533 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZDPMVf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Apr 2009 08:21:35 -0400
Content-Disposition: inline
In-Reply-To: <20090416115641.GA15237@gandalf.dyndns.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 524344@bugs.debian.org, linux-acpi@vger.kernel.org

I forgot to add that it is also nothing of the backlight setting itself,
because calling
	xbacklight -set NN
does not make AltGr unusable.

On Do, 16 Apr 2009, Norbert Preining wrote:
> I am having the following strange phenomenon:
> 
> When I log into the gnome session the AltGr key is working, thus on my
> German kbd I get
>    AltGr-q -> AT sign
>    AltGr-8 -> open square bracket
>    ...
> As soon as I adjust the brightness with Fn-F5 or Fn-F6 the OSD with the
> brightness level appears, the brightness is adjusted, but at the same
> time the functionality of the AltGr key is lost. Pressing AltGr-q I get 
> a q instead of the AT sign.
> 
> This is 100% repeatable, and happens only in Gnome. I tried the failsafe
> terminal session and pressing the keys did not change anything, nor the
> brightness, nor the AltGr behaviour.
> 
> So I guess that the culprit is one of those adjusting the brightness, and
> not the hardware support for sending the kbd events.
> 
> Since a missing AltGr on a German kbd means there is no AT, no curly nor
> square brackets, etc, that is very disturbing, and I need to restart X 
> to get normal behaviour back.
> 
> Hard/Software:
> - Sony Vaio VGN-Z11
> - kernel 2.6.29 plus latest sony-acpi patches from Mattia/ACPI ML
> - Debian/sid up2date
> 
> Hope that someone can help me there

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
KIRBY MISPERTON (n.)
One who kindly attempts to wipe an apparent kirby (q.v.) off another's
face with a napkin, and then discovers it to be a wart or other
permanent fixture, is said to have committed a 'kirby misperton'.
			--- Douglas Adams, The Meaning of Liff
