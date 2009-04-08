From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [RFC] [intel-gfx] :The backlight issue when KMS is used
Date: Wed, 08 Apr 2009 08:56:19 +0800
Message-ID: <1239152179.3635.8.camel@localhost.localdomain>
References: <1238737778.3582.163.camel@localhost.localdomain>
	 <20090403092408.66809996@hobbes> <20090403162906.GB23243@srcf.ucam.org>
	 <1239075911.3582.206.camel@localhost.localdomain>
	 <20090407055717.GA14710@srcf.ucam.org>
	 <1239089123.3582.228.camel@localhost.localdomain>
	 <20090407073845.GA15635@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31244 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbZDHAzM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Apr 2009 20:55:12 -0400
In-Reply-To: <20090407073845.GA15635@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "sonne@debian.org" <sonne@debian.org>, "Zhang, Rui" <rui.zhang@intel.com>, "rpurdie@linux.intel.com" <rpurdie@linux.intel.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Tue, 2009-04-07 at 15:38 +0800, Matthew Garrett wrote:
> On Tue, Apr 07, 2009 at 03:25:23PM +0800, yakui_zhao wrote:
> > On Tue, 2009-04-07 at 13:57 +0800, Matthew Garrett wrote:
> > > No, since in UMS mode the X server handles the backlight register=
s.
> > If so, there is no change about the backlight flowchart in UMS mode=
=2E
> >=20
> > And only when the KMS mode is used, a new backlight I/F is register=
ed.
> > Right?
>=20
> Right.
>=20
> > > The acpi case is uninteresting - acpi_video_backlight_support() d=
oesn't=20
> > > require the acpi video driver. The platform driver case is more=20
> > > interesting, but the easiest solution is probably to add a notifi=
er=20
> > > chain for backlight device add and have i915 unregister when a pl=
atform=20
> > > device registers.
> > Yes. We will have to create the communication channel between backl=
ight
> > device and i915 driver. And when a backlight I/F is registered, we =
will
> > have to check whether the backlight I/F in 915 should be unregister=
ed.=20
> > Right?=20
> > Does this make the problem complex?=20
>=20
> Not really. It's not a lot of code.
=EF=BB=BFWhen a new backlight I/F is registered, it should unregister t=
he
backlight I/F registered in 915 driver if it exists. And before i915
driver registers a backlight I/F, it will have to check whether the
backlight I/F is already registered by other code. If it exists, it wil=
l
give up.
And this code seems hack.=20

If so, we will have to do so even for the boxes based on non-intel
platforms.=20
>=20
> > > I'm not sure what you mean by arbiter order?
> > What I said is which backlight I/F should be selected if there exis=
t
> > multiple backlight I/F?
>=20
> The platform-specific one.
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
