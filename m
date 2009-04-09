From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: delete check for AML access to port 0x81-83
Date: Thu, 9 Apr 2009 07:56:46 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308581D26B32F@orsmsx503.amr.corp.intel.com>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
 <alpine.LFD.2.00.0904071754230.4799@localhost.localdomain>
 <20090409062346.GA8101@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:17809 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758994AbZDIO4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Apr 2009 10:56:48 -0400
In-Reply-To: <20090409062346.GA8101@srcf.ucam.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>
Cc: Rodrigo Luiz <rodrigo@gus-mg.org>, "malattia@linux.it" <malattia@linux.it>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

A 4-byte write to an I/O port means four one-byte writes to four consecutive I/O ports (although, this can be done in one machine instruction.)

>From our testing, Windows indeed is only allowing the single-byte write to the (legal) port 0x80. The rest of the request is simply ignored. In general, any part of an I/O request that overlaps the protected ports is ignored. No error is returned.

We are updating ACPICA to match this behavior.

Bob


>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Matthew Garrett
>Sent: Wednesday, April 08, 2009 11:24 PM
>To: Len Brown
>Cc: Rodrigo Luiz; malattia@linux.it; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH] ACPICA: delete check for AML access to port 0x81-83
>
>On Tue, Apr 07, 2009 at 05:56:09PM -0400, Len Brown wrote:
>> From: Len Brown <len.brown@intel.com>
>>
>> Sony laptops apparently write 4-bytes (rather than 1 byte)
>> to debug port 0x80, which spews error messages:
>
>So admittedly I should just check the spec here instead, but: what does
>a 4 byte write to an io port mean? It seems a bit odd that Sonys could
>be scribbling over DMA1 without causing any problems. Is Windows turning
>this into a single byte write to the defined io port instead?
>
>--
>Matthew Garrett | mjg59@srcf.ucam.org
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
