From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [0/5] remove ACPI motherboard driver, use PNP system driver instead (take 2)
Date: Thu, 15 Feb 2007 20:57:11 -0700
Message-ID: <200702152057.11626.bjorn.helgaas@hp.com>
References: <200701181636.45590.bjorn.helgaas@hp.com> <414cba4e0702031416p7b792addwf9cdbef797804136@mail.gmail.com> <414cba4e0702091115t472cc4b4s437b06ea7ffd6b71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:39859 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423113AbXBPD5S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Feb 2007 22:57:18 -0500
In-Reply-To: <414cba4e0702091115t472cc4b4s437b06ea7ffd6b71@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: emisca <emisca.ml@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Friday 09 February 2007 12:15, emisca wrote:
> I saw this error message using pnpacpi=off, on kernel boot, before resume:
> PnPBIOS: Resource structure does not contain an end tag.
> 
> What does it means?

I think this indicates a BIOS defect.  PNPBIOS gives us a list
of resources a device is using.  The list contains things like
the memory and I/O port ranges claimed by a device, the 
interrupt it uses, etc.  There's supposed to be an "end"
tag at the end of the list.  Apparently your BIOS didn't
supply the "end" tag.

This should be harmless, as long as the resources that *are*
in the list are correct.  The message is currently KERN_ERR;
maybe it would make more sense to be KERN_WARN.

Bjorn

P.S.  I promise to look at the logs you posted soon :-)

