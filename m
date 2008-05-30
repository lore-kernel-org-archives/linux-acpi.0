From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 00/15] PNP: convert resource options to unified dynamic list, v1
Date: Fri, 30 May 2008 16:48:53 -0600
Message-ID: <20080530224853.976744229@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:2394 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYE3Wt1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 May 2008 18:49:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

This patch series converts the PNP resource option structures
to a unified linked list.  This preserves resource order, which
is important for some devices.  There's more detail in the
comments for the last patch.

Any comments would be welcome.

This depends on some patches that are in -mm, but not yet
upstream.  In mmotm, these would probably go after
pnp-dont-sort-by-type-in-sys-resources.patch

Bjorn
-- 
