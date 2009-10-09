From: Jeff Mahoney <jeffm@suse.com>
Subject: [patch 0/2] ACPI: generic initramfs table override support #3
Date: Fri, 09 Oct 2009 15:55:08 -0400
Message-ID: <20091009195508.694274257@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52738 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761298AbZJIUBc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Oct 2009 16:01:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: =?UTF-8?q?=C3=89ric=20Piel?= <Eric.Piel@tremplin-utc.net>, Jan Beulich <JBeulich@novell.com>, Thomas Renninger <trenn@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@hera.kernel.org>

 This patch set contains two patches:

 1) Move populate_rootfs back to start_kernel, so it can be used by
    acpi_early_init
 2) Add the ability to override ACPI tables from the initramfs

 I'd like some review for the second patch. I expect objections to what is
 essentially open coding the top of acpi_load_table in a separate function,
 but Jan Beulich advised me that modifying code under acpica/ was not
 recommended. Ideally there would be a way to replace an existing table
 before it is loaded, or at the very least be able to request the table
 descriptor instead of just the table header.

 I've tested this patch set successfully at home, but I don't have a
 particularly exotic setup.

 Thanks!

 -Jeff

--
Jeff Mahoney
SuSE Labs

