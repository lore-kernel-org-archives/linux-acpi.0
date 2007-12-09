From: Volker Braun <volker.braun@physik.hu-berlin.de>
Subject: Re: suspend to RAM failure on t61p
Date: Sun, 9 Dec 2007 23:48:23 +0000 (UTC)
Message-ID: <pan.2007.12.09.23.48.22@physik.hu-berlin.de>
References: <20071209011928.c9873c66.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:48445 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbXLIXsf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Dec 2007 18:48:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J1Vsr-0007CX-Fe
	for linux-acpi@vger.kernel.org; Sun, 09 Dec 2007 23:48:29 +0000
Received: from carrot.hep.upenn.edu ([128.91.45.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 09 Dec 2007 23:48:29 +0000
Received: from volker.braun by carrot.hep.upenn.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 09 Dec 2007 23:48:29 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Sun, 09 Dec 2007 01:19:28 -0800, Andrew Morton wrote:
> 2.6.24-rc4 on a Lenovo t61p, using FC8 config.
> echo mem > /sys/power/state while running X.

On Fedora you should use System->Suspend or /usr/bin/pm-suspend from pm-
utils. See also /usr/share/hal/fdi/information/10freedesktop/20-video-
quirk-pm-lenovo.fdi, maybe you can fix yours if it still doesn't work.

Volker

