From: Len Brown <lenb@kernel.org>
Subject: Re: DMI update - Lenovo X61x - Region EmbeddedControl(3) has no handler
Date: Thu, 7 Feb 2008 13:39:25 -0500
Message-ID: <200802071339.26113.lenb@kernel.org>
References: <Pine.LNX.4.64.0802071146100.30873@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36201 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbYBGSju (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 13:39:50 -0500
In-Reply-To: <Pine.LNX.4.64.0802071146100.30873@twin.jikos.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-acpi@vger.kernel.org

On Thursday 07 February 2008 05:47, Jiri Kosina wrote:
> Hi,
> 
> sending DMI info as suggested by dmesg output.
> 
> BTW does anyone have any idea about the parse errors?
> 
> ACPI: EC: EC description table is found, configuring boot EC
> ACPI Error (evregion-0316): No handler for Region [ECOR] 
> (ffff81007d36f620) [EmbeddedControl] [20070126]
> ACPI Error (exfldio-0289): Region EmbeddedControl(3) has no handler 
> [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed 
> [\_SB_.PCI0.LPC_.EC__.AC__._PSR] (Node ffff81007d374630), AE_NOT_EXIST
> ACPI Error (psparse-0537): Method parse/execution failed 
> [\_SB_.PCI0.LPC_.EC__.HKEY.CKC4] (Node ffff81007d374270), AE_NOT_EXIST
> ACPI Error (psparse-0537): Method parse/execution failed [\_GPE._L02] 
> (Node ffff81007d3807d0), AE_NOT_EXIST
> ACPI Exception (evgpe-0576): AE_NOT_EXIST, while evaluating GPE method 
> [_L02] [20070126]
> Completing Region/Field/Buffer/Package 
> initialization:.............................................................................................................................
> .........................................................................................................................................
> Initialized 31/34 Regions 122/122 Fields 52/52 Buffers 57/73 Packages 
> (1845 nodes)
> Initializing Device/Processor/Thermal objects by executing _INI 
> methods:.<5>ACPI: BIOS _OSI(Linux) query honored via cmdline
> ACPI: DMI System Vendor: LENOVO
> ACPI: DMI Product Name: 76693KG
> ACPI: DMI Product Version: ThinkPad X61s
> ACPI: DMI Board Name: 76693KG
> ACPI: DMI BIOS Vendor: LENOVO
> ACPI: DMI BIOS Date: 12/28/2007
> ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
> ACPI: EC: non-query interrupt received, switching to interrupt mode

thanks for the messages.
Please open a sighting here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

please attach the complete output from dmesg -s64000
and the output from acpidump.

-Len
