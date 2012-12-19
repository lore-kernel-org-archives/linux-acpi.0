From: Lekensteyn <lekensteyn@gmail.com>
Subject: Re: [PATCH] ACPI: return first _ADR match for acpi_get_child
Date: Wed, 19 Dec 2012 23:40:47 +0100
Message-ID: <4931572.xMaToDeW2Z@al>
References: <8150264.b2f1OROKxE@al> <1494285.q9tABqzzMu@al> <2271508.zSFZF7r2W9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:41396 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab2LSWlM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Dec 2012 17:41:12 -0500
Received: by mail-ee0-f43.google.com with SMTP id e49so1340034eek.30
        for <linux-acpi@vger.kernel.org>; Wed, 19 Dec 2012 14:41:10 -0800 (PST)
In-Reply-To: <2271508.zSFZF7r2W9@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Sergio Perez <dagobertstaler@gmail.com>, "Moore, Robert" <robert.moore@intel.com>

Hi,

On Wednesday 19 December 2012 12:31:35 Rafael J. Wysocki wrote:
> > This is a well-aimed shot in the dark based on the DSDT I see.
> 
> Can you post that DSDT by chance?
The DSDT for a Lenovo Ideapad Y470 has been posted before to 
https://bugzilla.kernel.org/show_bug.cgi?id=42696.

>From dsdt.dsl,
line 9279 (context Device(\_SB.PCI0.PEG0)):

    Name (_ADR, 0x00010000)

line 9377 (context Device(\_SB.PCI0.PEG0.PEGP)):

    Name (_ADR, 0xFFFF)

line 9414 (context Device(\_SB.PCI0.PEG0.VGA)):
 Name (_ADR, Zero)

>From ssdt6.dsl, line 1070, (context Device(\_SB.PCI0.PEG0.PEGP)):
    Method (_INI, 0, NotSerialized)
    {
        Store (Zero, \_SB.PCI0.PEG0.PEGP._ADR)
    }

> > It is certainly 
> > not a solid proof that is won't break other machines and if it does break.
> > As  far as PCI is concerned, it only affects machines with multiple
> > handles that have the same PCI address returned by _ADR.
> 
> I wonder if there are any other criteria we can use to choose the "best"
> handle in those cases?  It doesn't look like choosing the first on or the
> last one is really going to always work.
Currently I do not have other ideas to get this to work, but Intel may have an 
ACPI expert who can help out here based on experience.

Regards,
Peter
