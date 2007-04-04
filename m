From: Johan Brannlund <johan_brn@yahoo.com>
Subject: Minor acpi problems on nx6125
Date: Wed, 4 Apr 2007 20:31:34 +0000 (UTC)
Message-ID: <ev11v6$ets$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:40592 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbXDDUfH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Apr 2007 16:35:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HZCC6-00061x-6f
	for linux-acpi@vger.kernel.org; Wed, 04 Apr 2007 22:35:02 +0200
Received: from jbrannlund.mathstat.dal.ca ([129.173.119.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 04 Apr 2007 22:35:02 +0200
Received: from johan_brn by jbrannlund.mathstat.dal.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 04 Apr 2007 22:35:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi. I have an HP nx6125, whose acpi implementation seems to be somewhat
notorious. With the most recent kernels, I now have most things working,
there are just a few minor things left:

1. With the laptop running on AC, the fan is always on at a low speed.
Unplugging the power makes the fan turn off (and re-plugging does not
make it come back on). There is a "fan always on when on ac" option in the
bios, but that's turned off. Does anyone have any idea why it does this?

2. I just looked into what sort of wakeup events this machine can process,
but the list is somewhat hard to decipher:

$ cat /proc/acpi/wakeup
Device  Sleep state     Status
C047       4            disabled
C0AB       4            disabled
C1D2       5            disabled
C0DD       3            disabled
C0E3       3            disabled
C0E8       3            disabled
C1D4       3            disabled
C1D5       3            disabled

How do I find out which devices these are? The hex codes do not appear in
any other file in /proc or /sys. 

3. When on battery, the max cpu frequency drops down from 1.8 ghz to 1.6
ghz. This is easily fixed by echoing back the higher value into the
appropriate file in /sys, but it's still somewhat annoying. I assume this
is the bios playing tricks on me?

By the way, I'm running the latest bios available from HP, F.11, released
August 29, 2006.

Thanks in advance for any help!

- Johan

