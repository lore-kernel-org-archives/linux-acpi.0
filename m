From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [ACPICA] EmbeddedControl region handling bug in PNP0C14
Date: Wed, 28 Nov 2007 03:50:08 +0000
Message-ID: <200711280350.08539.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:38475 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbXK1Dv2 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 27 Nov 2007 22:51:28 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

The following is, I think, a bug in ACPICA (so CC'ing Robert Moore).

(The full DSDT for the laptop in question (Acer Aspire 5040) is available 
here - I'm just going to selectively quote from it in this e-mail:
http://aceracpi.googlecode.com/svn/trunk/dsdt/acer/aspire/5040.dsl
)

ACPI is choking on the second of two OperationRegion's in different parts of 
the DSDT, with the same name, and that both operate on the Embedded 
Controller.

This hasn't cropped up before on the laptop in question (an Acer Aspire 5040 - 
based on the DSDTs I've collected so far for Acer laptops, I suspect a few 
others will have the same problem), as the second OperationRegion, in this 
case, is found in \_SB.AMW0 (aka WMI-ACPI or PNP0C14); and in acer_acpi, I've 
only just started poking at this (the first time by accident, the second time 
by more closely studying the DSDT - unfortunately, I don't have the hardware 
in question).

So, on the DSDT in question, we are trying to call \_SB.AMW0.WMCA

In ACPI land, it takes three arguments:

1) Instance (ACPI_TYPE_INTEGER)
2) Method ID (ACPI_TYPE_INTEGER)
3) Buffer (u32 in this case)

When we call it (we already know what the correct values to pass are, both 
from reverse engineering, and from visual inspection of the DSDT), we always 
get the following result (this is from a user with a 2.6.22 kernel):

[  699.477048] ACPI Error (evregion-0316): No handler for Region [RAM_] 
(ffff8100012b7ac0) [EmbeddedControl] [20070126]
[  699.477055] ACPI Error (exfldio-0289): Region EmbeddedControl(3) has 
no handler [20070126]
[  699.477060] ACPI Exception (dswexec-0462): AE_NOT_EXIST, While 
resolving operands for [OpcodeName unavailable] [20070126]
[  699.477066] ACPI Error (psparse-0551): Method parse/execution failed 
[\_SB_.AMW0.WMCA] (Node ffff810035e55400), AE_NOT_EXIST

The part of the DSDT we appear to be choking on is in \_SB.AMW0 (_HID 
PNP0C14):

OperationRegion (RAM, EmbeddedControl, 0x00, 0xFF)

(Followed by lots of Field() bits, which depend on the region RAM being 
defined).

Of course, in \_SB.PCI0.LPC0.EC0 (PNP0C09) we have exactly the same line, 
which works just fine:

OperationRegion (RAM, EmbeddedControl, 0x00, 0xFF)

So, I suspect either:

1) ACPICA does not handle EmbeddedControl outside of PNP0C09 (or, at least, 
can't handle it properly in PNP0C14, or in this case, *pnp0c14)

or

2) ACPICA is having a namespace clash with two identically named regions both 
trying to access EmbeddedControl? (But given that EC0 works fine, I'm not 
sure how likely this is).

Of course, if this bug is already known and has been fixed in something newer 
than 2.6.22, please let me know - I don't have the hardware in question, so 
cannot confirm this myself.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
