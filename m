From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/8] PNP: convert resource table to dynamic list, v1
Date: Mon, 05 May 2008 16:36:30 -0600
Message-ID: <20080505223630.682082986@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:45600 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760664AbYEEWj6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 May 2008 18:39:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This series replaces the fixed-size pnp_resource_table with a
linked list of resources.

The first patch is in -mm already and should appear in Linus'
tree soon, so just skip that patch if necessary.

As a reminder, if anybody tests this and sees problems, the
dmesg log with CONFIG_PNP_DEBUG enabled would be a great help
to me.

Bjorn

-- 
