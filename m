From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/2] PNP Lindent
Date: Thu, 26 Jul 2007 09:37:59 -0600
Message-ID: <20070726153759.333932655@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:45057 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765585AbXGZPsT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 11:48:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run PNP files through Lindent.  These patches contain no functional
changes.  I verified that the i386 object files before and after are
identical like this:

    $ grep PNP .config
    # CONFIG_IP_PNP is not set
    CONFIG_PNP=y
    CONFIG_PNP_DEBUG=y
    CONFIG_ISAPNP=y
    CONFIG_PNPBIOS=y
    CONFIG_PNPBIOS_PROC_FS=y
    CONFIG_PNPACPI=y
    CONFIG_BLK_DEV_IDEPNP=y
    CONFIG_SERIAL_8250_PNP=y
    $ quilt pop -a
    $ make bzImage
    $ mkdir /tmp/before
    $ cp -pr * /tmp/before/
    $ quilt push 2
    $ make bzImage
    $ find . -name \*.o -exec cmp /tmp/before/'{}' '{}' \;

Andrew and Len, thanks for your flexibility.  I know patches like
these are a nuisance.

Bjorn

--
