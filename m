From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] video: always update the brightness when poking
	"brightness"
Date: Wed, 31 Dec 2008 09:43:01 +0800
Message-ID: <1230687781.562.249.camel@rzhang-dt>
References: <1230088058.562.219.camel@rzhang-dt>
	 <1230633250.5328.8.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55301 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbYLaBpc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 20:45:32 -0500
In-Reply-To: <1230633250.5328.8.camel@dax.rpnet.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tue, 2008-12-30 at 18:34 +0800, Richard Purdie wrote:
> On Wed, 2008-12-24 at 11:07 +0800, Zhang Rui wrote:
> > bd->props.brightness is a cached value.
> > the current code has some potential problems when poking the
> > backlight I/F.
> >=20
> > For example,
> > 1. set the brightness level to 5 via sysfs I/F
> > 2. set the backlight to another level via the procfs,
> > 3. setting it back to 5 doesn't work because bd->props.brightness
> > is still 5.
> >=20
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D12249
>=20
> The root of the problem here is that there are two interfaces
> controlling the same piece of hardware.
then how about this case:
=EF=BB=BF1. set the brightness level to 5 via sysfs I/F
2. set the backlight to another level via HOTKEYS.
3. setting it back to 5 doesn't work because bd->props.brightness
is still 5.

> Personally, I'd like to see the
> proc interfaces to backlights depreacated but we do need to make them
> work I guess. The real bug looks like the proc interface should updat=
e
> props.brightness for that hardware...
IMO, the real problem is that bd->props.brightness doesn't reflect the
actual brightness.
If we can make sure that =EF=BB=BFbd->props.brightness is always update=
d when
the brightness is change, we won't have this problem any more.
But I'm afraid we can't, because backlight can be changed in other ways=
,
either via procfs or hotkeys.
Of course we can fix these two problems in the ACPI video driver, but I
think this patch is safer. because we don't know if there is any other
case besides procfs and hotkey that is not covered.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
