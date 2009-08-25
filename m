From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Less strict requirements for video device detection (v3)
Date: Tue, 25 Aug 2009 09:08:04 +0800
Message-ID: <1251162484.3483.51.camel@rzhang-dt>
References: <4A8D140F.1090909@canonical.com>
	 <1250817458.17853.141.camel@rzhang-dt>  <4A8E7022.8000707@canonical.com>
	 <1251076781.3483.13.camel@rzhang-dt>  <4A92A73C.7010003@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1667 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018AbZHYBJZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Aug 2009 21:09:25 -0400
In-Reply-To: <4A92A73C.7010003@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Acked-by: Zhang Rui <rui.zhang@intel.com>

On Mon, 2009-08-24 at 22:44 +0800, Stefan Bader wrote:
> Zhang Rui wrote:
> > On Fri, 2009-08-21 at 18:00 +0800, Stefan Bader wrote:
> >> Zhang Rui wrote:
> >>> On Thu, 2009-08-20 at 17:14 +0800, Stefan Bader wrote:
> >>>> Hardware: Acer 6920G (from a bug report)
> >>>>
> >>>> Another case of a broken BIOS. In this case there are several de=
finitions for=20
> >>>> video bus devices but only one has _DOS and _DOD defined. All ot=
her definitions=20
> >>>> only have _DOD.
> >>> I have seen such kind of BIOS too.
> >>>
> >>>> In the past (2.6.27) _ADR was not evaluated to make sure of usin=
g a present=20
> >>>> video device, but with that bug brightness could be changed.
> >>>>
> >>>> Now the video bus having _DOS and _DOD is detected as not being =
present. The=20
> >>>> other definitions are not considered because they are lacking th=
e _DOS method.
> >>>> Using the attached patch, would cause the detection code to cons=
ider the other=20
> >>>> definitions and has been tested to enable backlight control.
> >>>>
> >>>> Would this be an acceptable approach?
> >>> I think so. I generated a similar patch before, but didn't sent i=
t out
> >>> for some reason.
> >>> My suggestion is that we should also print out a warning message =
if _DOS
> >>> is missed, what do you think?
> >> Some indication about the problem can't hurt. Probably not in=20
> >> acpi_is_video_device as that would trigger for even unused devices=
=2E
> >> So I added a warning to acpi_video_bus_check for the case when _DO=
S is missing.=20
> >=20
> > =EF=BB=BFhow about using printk(KERN_WARNING FW_BUG "blabla")?
>=20
> I am not biased on that.
>=20
> -Stefan
> > thanks,
> > rui
> >=20
> >> The case of _DOS being present but _DOD not might also be worth a =
warning but=20
> >> (though the check in acpi_is_video_device prevented this) would ha=
ve been=20
> >> accepted by the current code.
> >> -Stefan
> >>
> >>> thanks,
> >>> rui
> >>>
> >>>>  From the ACPI spec it rather sounds like=20
> >>>> _DOD and _DOS must be present for a device for display switching=
 and _DOS would=20
> >>>> indicate possible backlight control as well. So the question mig=
ht not be so=20
> >>>> much is it the right thing than is it safe enough to allow more =
compatibility=20
> >>>> with broken implementations without causing other problems...
> >>>>
> >>>> -Stefan
> >>>>
> >>
> >=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
