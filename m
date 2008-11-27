From: Thomas Renninger <trenn@suse.de>
Subject: Video.ko-vs-toshiba.ko-more-brightness-levels-win
Date: Thu, 27 Nov 2008 12:39:25 +0100
Message-ID: <1227785967-10548-1-git-send-email-trenn@suse.de>
References: <alpine.LFD.2.00.0811270010260.3895@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:58172 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659AbYK0Lj3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Nov 2008 06:39:29 -0500
In-Reply-To: <alpine.LFD.2.00.0811270010260.3895@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: hmh@hmh.eng.br, mjg59@srcf.ucam.org, arvidjaar@mail.ru, rpurdie@rpsys.net, linux-acpi@vger.kernel.org

Does this work out?

I don't like the acpi_video_device_lcd_query_levels exported
in video_detect.c now.
But duplicating the code also did not look nice (maybe it's
still better?)
Better ideas?

Compile tested against latest Linus git tree.
Please test/review.

   Thomas


