From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] video: always update the brightness when poking "brightness"
Date: Wed, 31 Dec 2008 03:14:02 +0000
Message-ID: <20081231031402.GA25503@srcf.ucam.org>
References: <1230088058.562.219.camel@rzhang-dt> <1230633250.5328.8.camel@dax.rpnet.com> <1230687781.562.249.camel@rzhang-dt> <20081231020146.GA24861@srcf.ucam.org> <1230692328.562.289.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52686 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbYLaDOI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Dec 2008 22:14:08 -0500
Content-Disposition: inline
In-Reply-To: <1230692328.562.289.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, Dec 31, 2008 at 10:58:48AM +0800, Zhang Rui wrote:
> On Wed, 2008-12-31 at 10:01 +0800, Matthew Garrett wrote:
> > If you want the actual brightness, why aren't you reading=20
> > actual_brightness?
> >=20
> right, that's the problem.
> because IMO, we don't need the actual_brightness any more. :)
> And if you agree that =EF=BB=BFbd->props.brightness doesn't reflect t=
he actual
> brightness, we can see that

Brightness and actual_brightness have different semantics, and=20
maintaining that difference is worthwhile.

>                         if (bd->props.brightness !=3D brightness) {
>                                 bd->props.brightness =3D brightness;
>                                 backlight_update_status(bd);
>                         }
> doesn't make sense because =EF=BB=BF"bd->props.brightness !=3D bright=
ness" doesn't
> mean anything.

I agree that this doesn't seem like a meaningful check. For setups wher=
e=20
brightness change is an expensive operation, this could be done in the=20
driver rather than the core?

> But if =EF=BB=BFbd->props.brightness does reflect the actual brightne=
ss, then do
> we need "actual_brightness" any more?

I think maintaining "brightness" as "user requested brightness" is=20
sensible, for situations like Richard described.=20

Patch looks good to me.
--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
