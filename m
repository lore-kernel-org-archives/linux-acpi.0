From: Norbert Preining <preining@logic.at>
Subject: Sony laptop not rebooting
Date: Thu, 16 Oct 2008 14:04:14 +0200
Message-ID: <20081016120414.GA30291@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:56786 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYJPMwg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Oct 2008 08:52:36 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1KqRaQ-0000jd-RO
	for linux-acpi@vger.kernel.org; Thu, 16 Oct 2008 14:04:14 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.63)
	(envelope-from <preining@logic.at>)
	id 1KqRaQ-00008S-Pq
	for linux-acpi@vger.kernel.org; Thu, 16 Oct 2008 14:04:14 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all, 

I got a shiny new laptop Sony VAIO VGN-Z11VN. Most things work (well,
nothing seriously tested till now, like suspend).

But what I found is that reboot does not reboot, it hangs until I 4sec
press off.

Is there a fix for that? (kernel 2.6.27)

dmesg: http://www.logic.at/people/preining/sony/vgn-z11vn/dmesg.txt
confg: http://www.logic.at/people/preining/sony/vgn-z11vn/config-2.6.27
dmidecode: http://www.logic.at/people/preining/sony/vgn-z11vn/dmidecode.txt

Thanks for any comments, but rest assured I will report back for other
things, until I get everything working.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
PIMLICO (n.)
Small odd-shaped piece of plastic or curious metal component found in
the bottom of kitchen rummage-drawer when spring-cleaning or looking
for Sellotape.
			--- Douglas Adams, The Meaning of Liff
