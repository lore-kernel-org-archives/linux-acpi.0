From: Len Brown <lenb@kernel.org>
Subject: [GIT PATCH] delete pcc_acpi
Date: Thu, 23 Oct 2008 15:26:47 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810231525070.3005@localhost.localdomain>
References: <20081022172203.GA4000@kroah.com>
 <1224696563-5170-1-git-send-email-gregkh@suse.de>
 <alpine.LFD.1.10.0810221434070.3010@localhost.localdomain>
 <20081022184808.GA24150@suse.de>
 <alpine.LFD.1.10.0810222244130.3010@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:53632 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbYJWT7K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 15:59:10 -0400
In-reply-to: <alpine.LFD.1.10.0810222244130.3010@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hiroshi Miura <miura@da-cha.org>, YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>, Harald Welte <laforge@gnumonks.org>, linux-acpi@vger.kernel.org, Greg KH <gregkh@suse.de>

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

this old driver errantly went upstream with the staging stuff, but should 
not have.

This will update the files shown below.

thanks!

-Len

ps. individual patches are available on linux-acpi@vger.kernel.org
and a consolidated plain patch is available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.27/acpi-release-20080926-2.6.27.diff.gz

 drivers/staging/Kconfig             |    2 -
 drivers/staging/Makefile            |    1 -
 drivers/staging/pcc-acpi/Kconfig    |   11 -
 drivers/staging/pcc-acpi/Makefile   |    1 -
 drivers/staging/pcc-acpi/TODO       |    7 -
 drivers/staging/pcc-acpi/pcc-acpi.c | 1111 -----------------------------------
 6 files changed, 0 insertions(+), 1133 deletions(-)
 delete mode 100644 drivers/staging/pcc-acpi/Kconfig
 delete mode 100644 drivers/staging/pcc-acpi/Makefile
 delete mode 100644 drivers/staging/pcc-acpi/TODO
 delete mode 100644 drivers/staging/pcc-acpi/pcc-acpi.c

through these commits:

Len Brown (1):
      staging: pcc_acpi: delete obsolete driver

with this log:

commit 0d64cf8eba6de467f56bc43c4d8e28b0e3e335c5
Author: Len Brown <len.brown@intel.com>
Date:   Thu Oct 23 15:14:52 2008 -0400

    staging: pcc_acpi: delete obsolete driver
    
    pcc_acpi is based on an old version
    of drivers/misc/panasonic-laptop.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

