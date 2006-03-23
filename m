From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI error in 2.6.16 (AE_TIME, Returned by Handler for EmbeddedControl)
Date: Wed, 22 Mar 2006 20:45:17 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30067BF1BC@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23208 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932367AbWCWBp3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2006 20:45:29 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Francesco Biscani <biscani@pd.astro.it>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org, "Yu, Luming" <luming.yu@intel.com>


>sometimes at boot I get the following from the logs:
>
>ACPI: write EC, IB not empty
>ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for 
>[EmbeddedControl] [20060127]
>ACPI Error (psparse-0517): Method parse/execution failed 
>[\_SB_.PCI0.ISA_.EC0_.SMRD] (Node c13ecd40), AE_TIME
>ACPI Error (psparse-0517): Method parse/execution failed 
>[\_SB_.BAT1.UPBI] 
>(Node dbf42720), AE_TIME
>ACPI Error (psparse-0517): Method parse/execution failed 
>[\_SB_.BAT1.CHBP] 
>(Node dbf42660), AE_TIME
>ACPI Error (psparse-0517): Method parse/execution failed 
>[\_SB_.PCI0.ISA_.EC0_.SMSL] (Node c13ecce0), AE_TIME
>ACPI Error (psparse-0517): Method parse/execution failed 
>[\_SB_.PCI0.ISA_.EC0_._Q09] (Node c13ecc40), AE_TIME
>
>And after that the battery is reported as absent (even if it 
>is physically 
>present). I get the impression that this happens when rebooting, not 
>from "cold powerons".
>
>This did not happen in 2.6.15, it appeared somewhere in 
>2.6.16-rc series.

does this go away if you boot with "ec_intr=0"?

-Len
