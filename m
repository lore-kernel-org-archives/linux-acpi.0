From: Jan-Simon =?iso-8859-1?q?M=F6ller?= <dl9pf@gmx.de>
Subject: fsc esprimo v5505 - working with latest kernel (alsa.git branch)
Date: Mon, 15 Oct 2007 10:39:22 +0200
Message-ID: <200710151039.23130.dl9pf@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43738 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756410AbXJOIj0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Oct 2007 04:39:26 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I switched for some sound testing to the alsa.git branch  and now the 
backlight keys work. The default openSUSE 10.3 kernel does not work.

There are some other buttons left: Monitor switch, WLAN switch (kills wlan, 
but doesn't enable it).

Please correct me: we need to find the scancodes, then do an appropriate 
action (acpi or system), right ?

Greets
Jan-Simon
