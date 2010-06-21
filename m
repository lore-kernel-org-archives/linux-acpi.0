From: Andi Kleen <andi@firstfloor.org>
Subject: Re: 2.6.35-rc3 regression: IBM Maia system is unbootable [ACPI related?]
Date: Mon, 21 Jun 2010 18:18:17 +0200
Message-ID: <87pqzkqrzq.fsf@basil.nowhere.org>
References: <1277136189.10998.63.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:53725 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091Ab0FUQSW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jun 2010 12:18:22 -0400
In-Reply-To: <1277136189.10998.63.camel@mulgrave.site> (James Bottomley's
	message of "Mon, 21 Jun 2010 11:03:09 -0500")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> The system in question has a set of root bridges, with the CD rom (which
> is seen) being on bus 0 and the SCSI controller, which doesn't show up
> being on bus 1 (with several other things on busses > 1).
>
> The system uses ACPI to detect the multiple bridges, so it seems that
> this failure in 2.6.35-rc3:
>
> ACPI: Core revision 20100428
> ACPI Error: Hardware did not enter ACPI mode (20100428/evxfevnt-103)
> ACPI Warning: AcpiEnable failed (20100428/utxface-147)
> ACPI: Unable to enable ACPI

That probably causes all the other problems. Without ACPI enabled
modern systems generally do not work.

Just guessing, but maybe try to revert

b430acbd7c4b919886fa7fd92eeb7a695f1940d3

That was the last change in this area.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
