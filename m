From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Stable inclusion request - NVS changes from Matthew
Date: Tue, 29 Jun 2010 11:28:43 +0200
Message-ID: <201006291128.44099.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59734 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354Ab0F2JaR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Jun 2010 05:30:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, stable@kernel.org

Hi Greg,

Please include

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=dd4c4f17d722ffeb2515bf781400675a30fcead7
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2a6b69765ad794389f2fc3e14a0afa1a995221c2

(in this order) into the next 2.6.34.y release (and possibly older maintained
-stable kernels where they apply).

The first one requires a little fixup in kernel/power/Makefile , but apart from
this they apply to 2.6.34 just fine.

Thanks,
Rafael
