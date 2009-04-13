From: Norbert Preining <preining@logic.at>
Subject: sony_laptop and the Alt-key
Date: Tue, 14 Apr 2009 01:38:41 +0200
Message-ID: <20090413233841.GA12969@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:58912 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbZDMXi4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2009 19:38:56 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, sony-vaio-z-series@lists.launchpad.net, Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>

Ok, that sounds wierd, but I retried it about 10 times, repeatable:

- stop X
- start gdm
- login into a gnome session
- open terminal
- type AltGr-q (German kbd) and I get -> @
- use Fn-F5 or Fn-F6 to adjust the brightness
- type AltGr-q and I get -> q

(same with all AltGr combinations: \ } ] [ { ~ on German kbds, that is bad)

This is independent of the power plugged in or not.

It *IS* depending on Gnome, so I guess gnome-power-manager or something
else popping up that brightness OSD is the culprit.

Anyone here having an idea where that might come from, and how to track
that down?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
DEAL (n.)
The gummy substance found between damp toes.
			--- Douglas Adams, The Meaning of Liff
