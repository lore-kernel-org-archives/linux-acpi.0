From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.12-rc2-mm1: ACPI=y, ACPI_BOOT=n problems
Date: Wed, 6 Apr 2005 03:01:37 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3002F68228@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262123AbVDFHDM@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>, Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

>@Len:
>ACPI=y and ACPI_BOOT=n seems to be a legal configuration (with 
>X86_HT=y), but it breaks into pieces if you try the compilation.

yeah, don't do that:-)
I'm sorry I didn't push the patch to delete CONFIG_ACPI_BOOT earlier.
For now, just enable them both.

thanks,
-Len
