From: Norbert Preining <preining@logic.at>
Subject: sony-laptop: VGN-Z11VN, keys and wwanpower
Date: Mon, 10 Nov 2008 14:11:21 +0100
Message-ID: <20081110131121.GA9221@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:54867 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbYKJNLX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 08:11:23 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

Hi Mattia,

(all with 2.6.28-rc4 plus your sony-laptop patches as posted to the list
here)

I am coming back to my problems with Sony VGN-Z11VN. The current status
is that brightness adjustment via /sys interfaces work, but the hotkeys
for brightness do not work.

Furthermore, more important, the 
	/sys/devices/platform/sony-laptop/wwanpower
does not work.

I wanted to ask you whether you can propose something I can try. I can
hack the sony-laptop.c file to add more stuff, debugging, etc, but a
hint where to start with the Hotkey support would be great.

Concering the wwanpower sys file: I checked the content/cat-ing it and
it is always 0, regardless of booting into linux from turned off state
(and thus the device being not present/connected to the usb bus), or
rebooting from vista (the device being connected to the usb bus). In
both cases the file contains only 0. Also in this case, is there
anything I can do?

I thought about adding read entries for all unknown SPIC methods and see
if the value changes.

There is another idea: Maybe you know: Is there a way to *read* the
values of these methods under Vista? If yes, I can turn them off via the
sony driver, and read the value? Or some way of infering the sony driver
what it is doing?

In any case thanks for any suggestion and all the best

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
CLABBY (adj.)
A 'clabby' conversation is one stuck up by a commissionaire or
cleaning lady in order to avoid any further actual work. The opening
gambit is usually designed to provoke the maximum confusion, and
therefore the longest possible clabby conversation. It is vitally
important to learn the correct, or 'clixby' (q.v.), responses to a
clabby gambit, and not to get trapped by a 'ditherington' (q.v.). For
instance, if confronted with a clabby gambit such as 'Oh, mr Smith, I
didn't know you'd had your leg off', the ditherington response is 'I
haven't....' whereas the clixby is 'good.'
			--- Douglas Adams, The Meaning of Liff
