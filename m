From: Jakub Szefer <jszefer2@uiuc.edu>
Subject: Enabling ACPI on Asus P4B266
Date: Wed, 31 May 2006 19:18:06 -0500
Message-ID: <925f5bb3.c14b6d58.86ae000@expms4.cites.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from expredir4.cites.uiuc.edu ([128.174.5.187]:40694 "EHLO
	expredir4.cites.uiuc.edu") by vger.kernel.org with ESMTP
	id S965273AbWFAASN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 May 2006 20:18:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a Sony with an ASUS P4B266 motherboard which is on the
blacklist for incompatible BIOSes.  dmesg shows "ASUS P4B266
detected: force use of acpi=ht", if I understand correctly
ACPI gets disabled because of the motherboard type and
force=ht has to do with enabling support for hyperthreading?

I would like to make use of ACPI to control my fan speed (it
has two speeds, but right now keeps running at the highest all
the time).  Can I force ACPI to stay on or would this cause
some badness?

Thanks in advance for any advice you can offer,
~ Jakub
