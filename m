From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/2] PNPACPI: fix IRQ encoding problems
Date: Tue, 27 May 2008 16:49:15 -0600
Message-ID: <20080527224915.412211349@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:8857 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757060AbYE0Wte (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 May 2008 18:49:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Andrew Morton <akpm@linux-foundation.org>, Tom Jaeger <ThJaeger@gmail.com>

These patches fix some IRQ encoding problems in PNPACPI.  I
don't have reports of people hitting these specific problems,
but they could easily cause hard-to-debug suspend/resume failures
or failures when enabling devices left disabled by the BIOS.

I think these changes should go into 2.6.26.

Bjorn
-- 
