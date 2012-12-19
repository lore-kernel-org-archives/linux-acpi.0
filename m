From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: return first _ADR match for acpi_get_child
Date: Wed, 19 Dec 2012 12:31:35 +0100
Message-ID: <2271508.zSFZF7r2W9@vostro.rjw.lan>
References: <8150264.b2f1OROKxE@al> <50A6690B.2060805@kernel.org> <1494285.q9tABqzzMu@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:37611 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653Ab2LSL0W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 06:26:22 -0500
In-Reply-To: <1494285.q9tABqzzMu@al>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lekensteyn <lekensteyn@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Sergio Perez <dagobertstaler@gmail.com>, "Moore, Robert" <robert.moore@intel.com>

On Friday, November 16, 2012 07:37:34 PM Lekensteyn wrote:
> Thank you for your reply.
> 
> On Friday 16 November 2012 11:25:47 Len Brown wrote:
> > However, this patch can't possibly be the right way to go --
> > as it is just as broken as the code it replaces.
> This is a well-aimed shot in the dark based on the DSDT I see.

Can you post that DSDT by chance?

> It is certainly 
> not a solid proof that is won't break other machines and if it does break. As 
> far as PCI is concerned, it only affects machines with multiple handles that 
> have the same PCI address returned by _ADR.

I wonder if there are any other criteria we can use to choose the "best" handle
in those cases?  It doesn't look like choosing the first on or the last one
is really going to always work.

> This method is also used by USB 
> and others which I am more worried about (still, I think it will not happen, 
> but hey, this is ACPI).
> 
> Nowhere in the ACPI spec is stated what should happen with duplicate _ADR 
> values for such devices. Maybe you can ask for a clarification on this at the 
> ACPI team? (given that the ACPI spec is also worked on by Intel)?
> (the Windows Hardware Certification Requirements [1] is also not helpful on 
> this topic)

Well, added Bob Moore to the CC list, perhaps he knows something about that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
