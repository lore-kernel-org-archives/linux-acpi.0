From: Norbert Preining <preining@logic.at>
Subject: Sony VGN-Z11VN: brightness not working and Fn keys are not reported
Date: Fri, 17 Oct 2008 01:56:47 +0200
Message-ID: <20081016235647.GA3009@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:49558 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758472AbYJPX4t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Oct 2008 19:56:49 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1Kqchz-0002ia-LA
	for linux-acpi@vger.kernel.org; Fri, 17 Oct 2008 01:56:47 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1Kqchz-0001B7-JR
	for linux-acpi@vger.kernel.org; Fri, 17 Oct 2008 01:56:47 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I digged a bit through the net and everything I found is that the Fn-F5
and -F6 (increase and decrease brightness) do nothing. Furthermore,
echoing anything between 0 and 7 to /sys/class/backlight/sony/brightness
also does nothing. Same with xbacklight.

I am using linux 2.6.27, config file at
confg: http://www.logic.at/people/preining/sony/vgn-z11vn/config-2.6.27

I suspect that the reason is that this laptop has 2 graphics cards built
in, one Intel and one nvidia. I am currently running the Intel (since it
uses less energy).

Any ideas, or better places where to ask?

Thanks a lot and all the best

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
PODE HOLE (n.)
A hole drilled in chipboard lavatory walls by homosexuals for any one
of a number of purposes.
			--- Douglas Adams, The Meaning of Liff
