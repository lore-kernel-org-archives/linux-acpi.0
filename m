From: Len Brown <lenb@kernel.org>
Subject: ACPICA vs. Linux status
Date: Tue, 29 May 2007 18:15:09 -0400
Message-ID: <200705291815.09493.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33070 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbXE2WPT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 May 2007 18:15:19 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org

> Subject: [Patch 1/8] ACPICA: Update _OSI string list

applied

> Subject: [Patch 2/8] ACPICA: Changes for Cygwin compatibility

applied

> Subject: [Patch 3/8] ACPICA: Support for external package objects as method arguments

applied after hand editing.
Unclear why hand-ending was necessary, as there were no Linux specific
changes to this file beneath this delta.
Must be either Lindent weirdness or 0x20070320, mentioned below.

> Subject: [Patch 4/8] ACPICA: Fixed possible corruption of global GPE list

applied

> Subject: [Patch 5/8] ACPICA: Fix for update of the Global Lock Handle

did not apply, as it conflicts with the pre-existing Linux fix here,
which I decided to keep for the time being.

> Subject: [Patch 6/8] ACPICA: Change to make Notify() operator completely synchronous

While the patch applied, it did not work, and is thus rejected.
It caused "cat temperature" on my nx6325 to deadlock someplace
in the region of a trip point.

> Subject: [Patch 7/8] ACPICA: Clear reserved fields for incoming ACPI 1.0 FADTs

applied.

> Subject: [Patch 8/8] ACPICA: Update version to 20070508

did not apply, and didn't hand-apply it for two reasons:
1. we don't yet include all the changes from 20070508.

2. It expects ACPICA version 0x20070320 underneath,
but Linux doesn't have that version, it is at 0x20070126.

Bob, Please send the patch series for 0x20070320.

thanks,
-Len
