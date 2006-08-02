From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] Repost: asus strict model checking
Date: Wed, 2 Aug 2006 16:12:58 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601214FA2@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53820 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932187AbWHBUNE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Aug 2006 16:13:04 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, trenn@suse.de
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

> As long as this is not officially specified (by ACPI consortium and/or
vendors)
> and such special Devices exist, it is the best we can do.

Platform specific methods will never be in the APCI spec --
by the virtue that they are non-standard and platform specific by
definition.

The vendors should be using vendor-specific PNP ID's. eg, IBM0068
when they put vendor specific devices in the DSDT.

When that is not available, Linux is going very far out on a limb
when it mines the name space to match specific internal variables,
as there is no reason they could not match some totally different
machine.
Certainly the platform specific drivers that the vendors ship
on Windows does not do this.  I don't know what they do -- maybe DMI?

-Len
