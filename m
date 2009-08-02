From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 0/8] eeepc-laptop fixes
Date: Sun, 02 Aug 2009 16:54:46 +0100
Message-ID: <4A75B6C6.3020805@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:47998 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbZHBPyt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2009 11:54:49 -0400
Received: by ewy10 with SMTP id 10so2535091ewy.37
        for <linux-acpi@vger.kernel.org>; Sun, 02 Aug 2009 08:54:48 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

I promised a specific race fix, which is in the second patch.  While
I was there, I found some other things I could fix as well.

Regards
Alan

eeepc-laptop: use a mutex to serialize pci hotplug (resume vs. notify)
eeepc-laptop: fix pci hotplug race on load and unload
eeepc-laptop: fix ordering of init and exit functions
eeepc-laptop: make input device a child of the platform device
eeepc-laptop: remove redundant rfkill_set_sw_state in resume handler
eeepc-laptop: check the 3G rfkill state on resume
eeepc-laptop: correct the description of the hibernation abort bug
eeepc-laptop: switch to dev_pm_ops
