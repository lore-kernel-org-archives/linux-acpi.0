From: Norbert Preining <preining@logic.at>
Subject: Sony backlight regression from 2.6.28 to 29-rc
Date: Mon, 19 Jan 2009 09:14:23 +0100
Message-ID: <20090119081423.GA25297@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:39207 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbZASIOZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jan 2009 03:14:25 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: malattia@linux.it, linux-acpi@vger.kernel.org

Dear all,

there is a regression from 2.6.28 to 2.6.29-rc, namely that the
backlight cannot be controlled anymore.

Previously I was able to get a working backlight control with late
2.6.28 kernels, not sure if I needed some patches posted by Mattia.

Now, with 2.6.29-rc2 with and without these patches the backlight does
not work at all, no change.

INterestingly changing the "values" in the sys-files does work (via
/sys/class/backlight/acpi_video0/brightness), either per hand or using
xbacklight. but there is no effect on the actual brightness.

And the sony_laptop sys entries have lost their brightness values.

Is there a way to restore this behaviour?

(Even better, get sony_laptop fixed completely?)

Hardware: Vaio VGN-Z11

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HARBLEDOWN (vb.)
To manoeuvre a double mattress down a winding staircase.
			--- Douglas Adams, The Meaning of Liff
