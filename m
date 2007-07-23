From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/3] ACPI autoload (v2)
Date: Mon, 23 Jul 2007 14:43:20 +0200
Message-ID: <1185194600.14451.43.camel@fanta4.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:56080 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363AbXGWMpB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 08:45:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Kay Sievers <kay.sievers@vrfy.org>

Hi Len,

I rebased my patches against your recent commits.
Changes to previous patch(es):
  - forgot fixed button hids in button.c
  - adjusted linux specific hids to your suggestions (e.g. LNXVIDEO)
  - renamed acpi_device_id to acpica_device_id
    (instead __acpi_device_id)
  - removed some unneeded comments

It would be great to still see this in 2.6.23.
If you have concerns about this, please let me know soon, as we then
need more ugly workarounds in userspace to get all ACPI modules loaded.

Kay: On the second patch I added your signed-off. IIRC you said this is
ok. Thanks a lot for your testing, review, suggestions, enhancements and
cleanups here.

    Thomas

