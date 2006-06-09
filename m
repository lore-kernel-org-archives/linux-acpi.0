From: Thomas Renninger <trenn@suse.de>
Subject: RE: 2.6.17-rc6-mm1 -- acpi_processor-0731 [00]
	processor_preregister_: Error while parsing _PSD domain information.
	Assuming no coordination
Date: Fri, 09 Jun 2006 16:48:18 +0200
Message-ID: <1149864498.5124.101.camel@queen.suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB6AAB19A@hdsmsx411.amr.corp.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-L3PAx/hHp/ORot5e2N0Q"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51368 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751435AbWFIOsB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jun 2006 10:48:01 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6AAB19A@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>, linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "Moore, Robert" <robert.moore@intel.com>


--=-L3PAx/hHp/ORot5e2N0Q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-06-08 at 02:27 -0400, Brown, Len wrote:
> This is -mm only (there is no _PSD parsing in Linus' tree)
> It is benign.
> We'll fix it before 2.6.18.

This is probably the same I saw recently when trying to disassemble an
SSDT (with ACPICA 27-01-2006).

Here is the plain table, hopefully it helps to fix that.
You should already get errors in the beginning of .dsl output file when
trying to disassemble it.

  Thomas

--=-L3PAx/hHp/ORot5e2N0Q
Content-Disposition: attachment; filename=ssdt_2
Content-Type: application/octet-stream; name=ssdt_2
Content-Transfer-Encoding: base64

U1NEVMQBAAABTkhQICAgIFBTU1RCTElEAQAAAEhQICABAAAAEE8MXC5fUFJfQzAwMAhfUENUEiwC
ERQKEYIMAH8AAAAAAAAAAAAAAHkAERQKEYIMAH8AAAAAAAAAAAAAAHkACF9QU1MSRgYDEiAGDAgH
AAAMoIYBAAxkAAAADAkAAAAMiiQw4AyKBAAAEiAGDEAGAAAMXzwBAAxkAAAADAkAAAAMCCUw4AwI
BQAAEiAGDCADAAAMOHQAAAxkAAAADAkAAAAMgCYw4AyABgAACF9QUEMKAAhfUFNEEg8BEhUFCgUK
AAwAAAAADP0AAAAMAQAAABBPDFwuX1BSX0MwMDEIX1BDVBIsAhEUChGCDAB/AAAAAAAAAAAAAAB5
ABEUChGCDAB/AAAAAAAAAAAAAAB5AAhfUFNTEkYGAxIgBgwIBwAADKCGAQAMZAAAAAwJAAAADIok
MOAMigQAABIgBgxABgAADF88AQAMZAAAAAwJAAAADAglMOAMCAUAABIgBgwgAwAADDh0AAAMZAAA
AAwJAAAADIAmMOAMgAYAAAhfUFBDCgAIX1BTRBIPARIVBQoFCgAMAAAAAAz9AAAADAEAAAA=


--=-L3PAx/hHp/ORot5e2N0Q--

