From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PM: x86-64 suspend-resume fix
Date: Sun, 15 Feb 2009 22:44:46 +0100
Message-ID: <200902152244.47326.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48279 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbZBOVr2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Feb 2009 16:47:28 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

The following two patches clean-up and fix the x86-64 resume code.

1/2 is a cleanup, but it is simple enough to be applied now IMO.

2/2 is a bug fix based on 1/2, which is 2.6.29 material.

Please apply them to the suspend branch and push to Linus for 2.6.29 (Ingo
says he doesn't mind if they go through your tree).

Thanks,
Rafael

