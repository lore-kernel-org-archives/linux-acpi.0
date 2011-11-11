From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] acpi_read() bit_offset support
Date: Fri, 11 Nov 2011 16:05:03 -0700
Message-ID: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gy0-f202.google.com ([209.85.160.202]:62830 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab1KKXMy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Nov 2011 18:12:54 -0500
Received: by gye5 with SMTP id 5so404689gye.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Nov 2011 15:12:53 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Huang Ying <ying.huang@intel.com>, Myron Stowe <myron.stowe@redhat.com>, Thomas Renninger <trenn@suse.de>

We seem to be stuck in a morass of issues surrounding APEI and generic
address structures.  I don't know how to cut that Gordian knot, but
here's a possible tiny step forward.

I think we have general agreement that acpi_read() and friends *should*
pay attention to the generic address structure bit_offset, so these patches
add support for it.  It's done the same way as in the APEI accessors, so I
hope there's consensus that the semantics are correct.

We believe that today, only APEI uses generic address structures with
non-zero bit_offset (based on the fact that Google doesn't find any
"Unsupported register bit offset" warnings).  APEI currently uses its
own accessors, so these patches don't affect it.
---

Bjorn Helgaas (2):
      ACPICA: acpi_read: update return value atomically
      ACPICA: support Generic Address Structure bit_offset in acpi_read/write


 drivers/acpi/acpica/hwregs.c  |   32 ++++++++++++++++++++------------
 drivers/acpi/acpica/hwxface.c |   17 +++++++++++------
 2 files changed, 31 insertions(+), 18 deletions(-)

-- 
Bjorn
