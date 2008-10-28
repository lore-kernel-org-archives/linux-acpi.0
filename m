From: Norbert Preining <preining@logic.at>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Tue, 28 Oct 2008 02:47:08 +0100
Message-ID: <20081028014708.GA2649@gamma.logic.tuwien.ac.at>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at> <Pine.LNX.4.63.0810251854180.10973@dashnine.joshuawise.com> <20081025233118.GA31722@gandalf.dynalias.org> <20081027232051.GI22083@gamma.logic.tuwien.ac.at> <20081028014148.GB28057@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:58980 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbYJ1BrK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2008 21:47:10 -0400
Content-Disposition: inline
In-Reply-To: <20081028014148.GB28057@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Joshua Wise <joshua@joshuawise.com>, linux-acpi@vger.kernel.org

Hi Mattia,

(taking the MMC guy out, this is not about the SD card reader anymore)

On Di, 28 Okt 2008, Mattia Dongili wrote:
> Yes, I am. But I have no idea what might be wrong. Did you also try
> xbacklight while in X and using the Intel card?

I am a step further on. Thanks to Ishikawa-san I have an sony-laptop.c
file which allows setting the backlight using the
/sys/devices/backlight/{sony,acpi_video0}/backlight files
(interestingly, they do not agree on their behaviour, xbacklight can
change in 12.5% jumps, that makes 9 different values, but allowed are
only 8 (from 0 to 7). In sony the 0% is missing, in acpi_video0 the 100%
is missing -- i.e., sony/brightness 0 is brighter than
acpi_video0/brightness 0, and so on).

But still the function keys do not work.

No idea what could be done here.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HEATON PUNCHARDON (n.) A violent argument which breaks out in the car
on the way home from a party between a couple who have had to be
polite to each other in company all evening.
			--- Douglas Adams, The Meaning of Liff
