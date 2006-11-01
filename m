From: Len Brown <len.brown@intel.com>
Subject: dynamic SSDT address
Date: Wed, 1 Nov 2006 03:58:22 -0500
Message-ID: <200611010358.22743.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:28310 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1423956AbWKAI6x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Nov 2006 03:58:53 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Starikovskiy, Alexey" <alexey_y_starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

Alexey,
The new table code prints out the line for a dynamically loaded SSDT,
but the address is 0.  Is it possible to find and print the address so that
we can use it for acpidump of a dynamic table?

thanks,
-Len

static: ACPI: SSDT @ 0x7f6d3a05/0x04DC (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624)

dynamic: ACPI: SSDT @ 0x00000000/0x0244 (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20050624)
