From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Less strict requirements for video device detection (v2)
Date: Mon, 24 Aug 2009 09:19:41 +0800
Message-ID: <1251076781.3483.13.camel@rzhang-dt>
References: <4A8D140F.1090909@canonical.com>
	 <1250817458.17853.141.camel@rzhang-dt>  <4A8E7022.8000707@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51206 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbZHXBU5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Aug 2009 21:20:57 -0400
In-Reply-To: <4A8E7022.8000707@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Fri, 2009-08-21 at 18:00 +0800, Stefan Bader wrote:
> Zhang Rui wrote:
> > On Thu, 2009-08-20 at 17:14 +0800, Stefan Bader wrote:
> >> Hardware: Acer 6920G (from a bug report)
> >>
> >> Another case of a broken BIOS. In this case there are several defi=
nitions for=20
> >> video bus devices but only one has _DOS and _DOD defined. All othe=
r definitions=20
> >> only have _DOD.
> >=20
> > I have seen such kind of BIOS too.
> >=20
> >> In the past (2.6.27) _ADR was not evaluated to make sure of using =
a present=20
> >> video device, but with that bug brightness could be changed.
> >>
> >> Now the video bus having _DOS and _DOD is detected as not being pr=
esent. The=20
> >> other definitions are not considered because they are lacking the =
_DOS method.
> >> Using the attached patch, would cause the detection code to consid=
er the other=20
> >> definitions and has been tested to enable backlight control.
> >>
> >=20
> >> Would this be an acceptable approach?
> >=20
> > I think so. I generated a similar patch before, but didn't sent it =
out
> > for some reason.
> > My suggestion is that we should also print out a warning message if=
 _DOS
> > is missed, what do you think?
>=20
> Some indication about the problem can't hurt. Probably not in=20
> acpi_is_video_device as that would trigger for even unused devices.
> So I added a warning to acpi_video_bus_check for the case when _DOS i=
s missing.=20

=EF=BB=BFhow about using printk(KERN_WARNING FW_BUG "blabla")?

thanks,
rui

> The case of _DOS being present but _DOD not might also be worth a war=
ning but=20
> (though the check in acpi_is_video_device prevented this) would have =
been=20
> accepted by the current code.
> -Stefan
>=20
> > thanks,
> > rui
> >=20
> >>  From the ACPI spec it rather sounds like=20
> >> _DOD and _DOS must be present for a device for display switching a=
nd _DOS would=20
> >> indicate possible backlight control as well. So the question might=
 not be so=20
> >> much is it the right thing than is it safe enough to allow more co=
mpatibility=20
> >> with broken implementations without causing other problems...
> >>
> >> -Stefan
> >>
> >=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
