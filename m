From: Len Brown <lenb@kernel.org>
Subject: multiple MADT issue & acpi_get_table()
Date: Sun, 11 Feb 2007 00:57:05 -0500
Message-ID: <200702110057.05952.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48216 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbXBKF6Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Feb 2007 00:58:25 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Starikovskiy, Alexey" <alexey.y.starikovskiy@linux.intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org

Alexey, Bob,

There are boxes with multiple MADT's in the RSDT,
and proof that Linux' current policy of choosing the 1st one
does not work around this BIOS bug properly.

http://bugzilla.kernel.org/show_bug.cgi?id=7465

Before the ACPICA table update, I had a patch in 7465
that made this situation verbose, and added a boot param so that
we could switch to using the last MADT and have a knob if
that didn't always work.

That patch is no good in 2.6.21 as ACPICA's acpi_get_table()
now owns finding the table instance.

Also, I see code in processor_core.c that is uses acpi_get_table()
to find the MADT -- so my patch in the bug report above probably
was incomplete anyway, as in some cases the table code would look at
one instance and the processor driver still looked a the 1st instance...

What do you suggest we do with acpi_map_table() to handle
the fact that when there are multiple MADT's, we probably always
want the last one?  Further, we need to issue a warning when this happens,
and we need a hook for a boot param in case it doesn't work for everybody.

Note that I've only seen this issue with the MADT.

thanks,
-Len
