From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: disable the ACPI backlight control on laptops with buggy _BCL methods
Date: Thu, 8 Jan 2009 12:43:42 +0000
Message-ID: <20090108124342.GA10458@srcf.ucam.org>
References: <1231383496.20746.44.camel@rzhang-dt> <20090108033250.GA2550@srcf.ucam.org> <1231396321.20746.79.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58169 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbZAHMnq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jan 2009 07:43:46 -0500
Content-Disposition: inline
In-Reply-To: <1231396321.20746.79.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "trenn@suse.de" <trenn@suse.de>

On Thu, Jan 08, 2009 at 02:32:01PM +0800, Zhang Rui wrote:
> > Why? These all seem to behave consistently, so I can't see any prob=
lem=20
> > with us simply adding support for this varient.
> the problem is that the ACPI backlight I/F and the platform I/F coexi=
sts
> before commit =EF=BB=BFc3d6de698c84efdbdd3781b7058bcc339ab43da8 appli=
ed, and the
> platform I/F is preferred.

=46or the machines you've looked at - we don't know if that's true for =
all=20
hardware that behaves this way.

> =EF=BB=BFin bug 12249 and 12037,
> 1. the first two elements in _BCL are NOT the backlight levels when t=
he
> platform is on AC or battery.

We can detect that easily and adjust behaviour accordingly.

> 2. _BQC returns the index of the current brightness =EF=BB=BF=EF=BB=BF=
in _BCL package
> rather than the value, which surely breaks the ACPI video driver.

And again, we can handle that.

> 2. every elements in the _BCL package is not a percentage of the maxi=
mum
> brightness, which is also a violation of ACPI spec.

This seems pretty irrelevant - nothing in the code depends on these=20
being percentages.

> yes, we can make the ACPI backlight control work by using customized
> DSDT. But that's not the fix neither. I don't have any better ideas t=
han
> disable them.

Just fix up video.c to handle these cases.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
