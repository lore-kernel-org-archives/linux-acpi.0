From: Len Brown <lenb@kernel.org>
Subject: [RFC] Linux/ACPI DSDT override page update
Date: Wed, 6 Feb 2008 21:38:39 -0500
Message-ID: <200802062138.40055.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59478 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758630AbYBGCjN (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Wed, 6 Feb 2008 21:39:13 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org, =?iso-8859-1?q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>, "Thomas Renninger (Novell/SUSE)" <trenn@suse.de>, dsdt <dsdt@gaugusch.at>, Philippe Coval <rzr@us>

Here are my proposed updates for
http://www.lesswatts.org/projects/acpi/overridingDSDT.php

thanks,
-Len
---
> iASL is part of the ACPICA release,
> http://www.intel.com/technology/iapc/acpi/downloads.htm. 

Please reference "http://acpica.org" instead.

Also, in the section titled "How to build a customer DSDT into an initrd",
please replace all of the text with the following:

If you are unable to re-build the kernel,
or you'd like to run the same kernel binary
on multiple machines that require different DSDT overrides,
then the initrd method should suite your needs.

For kernels before Linux-2.6.25, this method requires the out-of-tree patch
found here: http://gaugusch.at/kernel.shtml (thanks to Markus Gaugusch and Eric Piel)
Some distributors, such as SuSE and Ubuntu, included that patch,
and you can tell if it is present by finding the following line in the console log:

"Looking for DSDT in initramfs..."

In Linux-2.6.25 and later, this method is enabled via
CONFIG_ACPI_CUSTOM_DSDT_INITRD, and you can tell if a kernel
binary includes it by finding the following line in the console log:

"ACPI: Checking initramfs for custom DSDT"

The process for creating the DSDT image is the same as above.
But note that
the format of the table included in the initramfs is binary (iasl -ta),
while if you build a DSDT into the kernel, C-source code is used (iasl -tc).

In case your mkinitrd tool does not support this feature, a script is
provided in the kernel source tree,
Documentation/acpi/initramfs-add-dsdt.sh
