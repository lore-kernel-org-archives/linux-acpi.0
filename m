From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/2] ACPI: Avoid NULL derefernce when hotplugging
Date: Fri, 29 Jan 2010 17:48:49 +0100
Message-ID: <201001291748.49780.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34226 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab0A2Qsv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Jan 2010 11:48:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, kristen.c.accardi@intel.com

Hi,

these are against 2.6.32, but patch fine against latest
acpi release tree with a small offset.

Would be great to see them mainline soon.
The first is IMO a must for stable, eventually both should
end up there.

Thanks,

    Thomas
