From: Norbert Preining <preining@logic.at>
Subject: Re: Sony VGN-Z11VN: brightness not working and Fn keys are not reported
Date: Fri, 17 Oct 2008 11:02:19 +0200
Message-ID: <20081017090219.GA16070@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:47309 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbYJQJCV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2008 05:02:21 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1KqlDv-0006yL-Lp
	for linux-acpi@vger.kernel.org; Fri, 17 Oct 2008 11:02:19 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1KqlDv-0004fn-Ik
	for linux-acpi@vger.kernel.org; Fri, 17 Oct 2008 11:02:19 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear Ishikawa-san, dear Mattia, dear all,

On Fr, 17 Okt 2008, ISHIKAWA Hutsumi wrote
>> echoing anything between 0 and 7 to /sys/class/backlight/sony/brightness
>> also does nothing. Same with xbacklight.
>
> They are 2 different problems, here.
>
> 1) Fn key handling don't work
>
>      Fn key handling by sony-laptop driver does not work on VGN-Z.
>
>      Fn key or Fn key + some other function key press does not rise
>    evdev and acpi event on this machine. Some work will be needed...

Ok, I guess Mattia is listening. Here is my DSDT:
	http://www.logic.at/people/preining/sony/vgn-z11vn/DSDT.dsl
If I can help test something just let me know.

> 2) backlight control don't work
>
>     Backlight control on VAIO will be handled by Sony NC driver in
>   sony-acpi. VGN-Z* have Sony NC device [1], but SNC driver will not
>   enable it.
>
>
>     Backlight control without enabled SNC will not work via both
>   ACPI backlight(/sys/class/backlight/acpi_video0/brightness) and
>   sony-acpi backlight(/sys/class/backlight/sony/brightness)
>
>
>     Entry for VGN-Z* series should be added in sony_nc_ids table
>   of sony-laptop.c, patch bellow.
>
>     With SNC enabled, it works via /sys/class/backlight/sony/brightness.

I have added this patch to my kernel and rebuilt the kernel, but still
setting via echo n > /sys/class/backlight/sony/brightness does not work
(well, it changes the value there, but not the brightness).

Do I have to disable ACPI-VIDEO for this, too?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
GIPPING (participial vb.)
The fish-like opening and closing of the jaws seen amongst people who
have recently been to the dentist and are puzzled as to whether their
teeth have been put back the right way up.
			--- Douglas Adams, The Meaning of Liff
