From: Thomas Renninger <trenn@suse.de>
Subject: Do not return true to all kind of Windows OSI calls
Date: Sat,  2 Aug 2008 18:57:57 +0200
Message-ID: <1217696279-23848-1-git-send-email-trenn@suse.de>
References: <1217632817.4610.6.camel@hidalgo>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:54631 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754818AbYHBQ6B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Aug 2008 12:58:01 -0400
In-Reply-To: <1217632817.4610.6.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corsac@debian.org
Cc: ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, hmh@debian.org

ThinkPads store OSI calls in separate variables and later
check for NT/XP/VISTA specific code to process.

I lately saw a line on a ThinkPad checking for XP and VISTA
at video device specific code.

So currently some ThinkPads run into code paths which should
either run on XP or VISTA, but Linux might execute them both
or in a way that is not intended by BIOS developers.

Also be sure you have a recent BIOS running.

       Thomas


