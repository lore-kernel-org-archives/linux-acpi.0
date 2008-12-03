From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Regression from 2.6.28-rc7: Commit 7cd5b08be3 breaks startup on Toshiba Portege R500
Date: Wed, 3 Dec 2008 23:00:18 +0100
Message-ID: <200812032300.19110.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47915 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbYLCWA6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Dec 2008 17:00:58 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

Hi,

The following commit:

commit 7cd5b08be3c489df11b559fef210b81133764ad4
Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Wed Nov 19 19:39:58 2008 +0000

    [WATCHDOG] iTCO_wdt : problem with rebooting on new ICH9 based motherboards

    Bugzilla #9868: On Intel motherboards with the ICH9 based I/O controllers
    (Like DP35DP and DG33FB) the iTCO timer counts but it doesn't reboot the
    system after the counter expires.

    This patch fixes this by moving the enabling & disabling of the TCO_EN bit
    in the SMI_EN register into the start and stop code.

    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

makes CPU fan spin with full speed and causes hald-addon-acpi to take 100% of
CPU time on Toshiba Portege R500 with openSUSE 11.0 user space.  This starts as
soon as hal starts or thereabouts and never ends, which makes the current
mainline unusable on that box.

Thanks,
Rafael
