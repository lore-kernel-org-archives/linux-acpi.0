From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/6] ACPI: Simplifications of the GPE-handling code
Date: Fri, 25 Jun 2010 01:17:44 +0200
Message-ID: <201006250117.45148.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47183 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab0FXX0F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jun 2010 19:26:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, len.brown@intel.com, Alexey Starikovskiy <astarikovskiy@suse.de>

Hi,

The following patches are intended to simplify the GPE-handling code in
ACPICA and the kernel.

[1/6] and [2/6], already posted as https://patchwork.kernel.org/patch/107612/
and https://patchwork.kernel.org/patch/107613/ , respectively, rework the GPE
code so that reference counting is only used for GPEs enabled at run time.

[3/6] and [4/6] modify the EC driver so that it doesn't use acpi_set_gpe().

[5/6] modifies acpi_ev_initialize_gpe_block() so that it will use a low-level
GPE enabling routine instead of acpi_set_gpe().

Finally, [6/6] removes acpi_set_gpe() which is no longer necessary
(and there is a good reason to get rid of it).

Please apply.

Rafael

