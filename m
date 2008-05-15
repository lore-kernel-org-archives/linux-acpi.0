From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/4] PNP: convert resource table to dynamic list, v2
Date: Thu, 15 May 2008 16:07:26 -0600
Message-ID: <20080515220726.029505668@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:22707 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYEOW5W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 18:57:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

This series replaces the fixed-size pnp_resource_table with a
linked list of resources.

This iteration fixes a null pointer dereference Andrew found
on a PNPBIOS machine.

Because of that problem, Andrew dropped the following patches
from the -mm tree (these were patches 6-8 of the v1 series):

  pnp-replace-pnp_resource_table-with-dynamically-allocated-resources.patch
  pnp-remove-ratelimit-on-add-resource-failures.patch
  pnp-dont-sort-by-type-in-sys-resources.patch

This posting doesn't repeat patches 1-5 from the original v1 series;
the first is already in Linus's tree, and the rest are still in -mm.

Bjorn
-- 
