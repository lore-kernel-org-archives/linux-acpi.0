From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/2] Implement overriding of arbitrary ACPI tables via initrd
Date: Wed, 24 Aug 2011 11:48:08 +0200
Message-ID: <1314179290-31526-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32951 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756115Ab1HXJs0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Aug 2011 05:48:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: eric.piel@tremplin-utc.net, jnelson-suse@jamponi.net, devel@acpica.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com

This patch series got some basic testing already (see patch 2 changelog) and
is based on latest 3.1-rc2 Linus kernel.

The patches are separated into ACPICA parts (patch 1) and kernel parts (patch 2).

They are ready for integeration (if now objections should show up in a review
discussion) and it would be great if they can be added in Len's latest acpi-test
tree for broader testing.

Thanks,

   Thomas

