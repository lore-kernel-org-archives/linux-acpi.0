From: Len Brown <lenb@kernel.org>
Subject: Re: dmi info requested... - Dell - Precision WorkStation 690
Date: Tue, 12 Feb 2008 15:13:26 -0500
Message-ID: <200802121513.26658.lenb@kernel.org>
References: <47B0FA26.4010302@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34735 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754526AbYBLUOJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Feb 2008 15:14:09 -0500
In-Reply-To: <47B0FA26.4010302@tlinx.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Walsh <acpi@tlinx.org>
Cc: linux-acpi@vger.kernel.org

On Monday 11 February 2008 20:45, Linda Walsh wrote:
> ACPI: DMI System Vendor: Dell Inc.               
> ACPI: DMI Product Name: Precision WorkStation 690
> ACPI: DMI Product Version:
> ACPI: DMI Board Name: 0MY171
> ACPI: DMI BIOS Vendor: Dell Inc.                
> ACPI: DMI BIOS Date: 08/20/2007
> ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
> ----
> Note my 410 Workstation ID's DMI as 2.2, but doesn't
> seem to provide any output.  Should it at least provide
> the "send DMI info" line if it is enabled correctly?

not necessarily.

> What's this for, anyway?

It is part of a search for BIOS bugs triggered by BIOS use of _OSI(Linux).
This was indicated by the line following what you pasted above, which
probably read something like:

ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org

Please send me the output from acpidump for the machine
which printed out the DMI console messages above.

thanks,
-Len
