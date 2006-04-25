From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] reverse pci config space restore order
Date: Tue, 25 Apr 2006 14:22:08 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6466300@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18730 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932279AbWDYSX6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2006 14:23:58 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, abelay@MIT.EDU
Cc: "Yu, Luming" <luming.yu@intel.com>, Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


>On Tue, 2006-04-25 at 11:48 +0100, Matthew Garrett wrote:
>> On Tue, Apr 25, 2006 at 02:50:57PM +0800, Yu, Luming wrote:
>> 
>> > -	for (i = 0; i < 16; i++)
>> > +	for (i = 15; i >= 0 ; i--)
>> 
>> We certainly need to do /something/ here, but I'm not sure 
>> this is it. 
>> Adam Belay has code to limit PCI state restoration to the 
>> PCI-specified 
>> registers, with the idea being that individual drivers fix things up 
>> properly. While this has the obvious drawback that almost every PCI 
>> driver in the tree would then need fixing up, it's also probably the 
>> right thing.
>
>it has a second drawback: it assumes all devices HAVE a driver, which
>isn't normally the case...

Adam mentioned earlier, and I agree, that it is probably a bad
idea for this code to blindly scribble on the BIST field at i=3.
Probably we should clear that field before restoring it.

Re: this patch
I think that this patch is likely a positive forward step.
It seems logical to restore the BARs before the CMD/STATUS in general,
nothing specific to the ICH here.

But yes, this is a helper routine and devices where it hurts
instead of helps should have their own routine.  Complex devices
need to handle the device-specific config space state above these
1st 16 locations anyway.

-Len
