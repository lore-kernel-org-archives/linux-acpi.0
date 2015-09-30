From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/22] On-demand device probing
Date: Wed, 30 Sep 2015 12:23:04 +0200
Message-ID: <20150930102304.GA7435@kroah.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <5606E120.3070305@kernel.org>
 <20150926192218.GA15657@kroah.com>
 <CAAObsKChqEfFO+qTwLcBLs8tPPT_gchGKK287652jdC=5R6+qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKChqEfFO+qTwLcBLs8tPPT_gchGKK287652jdC=5R6+qQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Rob Herring <robh@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-acpi@vger.kernel.org

On Wed, Sep 30, 2015 at 12:09:27PM +0200, Tomeu Vizoso wrote:
> On 26 September 2015 at 21:22, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sat, Sep 26, 2015 at 01:17:04PM -0500, Rob Herring wrote:
> >> On 09/21/2015 09:02 AM, Tomeu Vizoso wrote:
> >> > Hello,
> >> >
> >> > I have a problem with the panel on my Tegra Chromebook taking lo=
nger
> >> > than expected to be ready during boot (St=E9phane Marchesin repo=
rted what
> >> > is basically the same issue in [0]), and have looked into ordere=
d
> >> > probing as a better way of solving this than moving nodes around=
 in the
> >> > DT or playing with initcall levels and linking order.
> >> >
> >> > While reading the thread [1] that Alexander Holler started with =
his
> >> > series to make probing order deterministic, it occurred to me th=
at it
> >> > should be possible to achieve the same by probing devices as the=
y are
> >> > referenced by other devices.
> >> >
> >> > This basically reuses the information that is already implicit i=
n the
> >> > probe() implementations, saving us from refactoring existing dri=
vers or
> >> > adding information to DTBs.
> >> >
> >> > During review of v1 of this series Linus Walleij suggested that =
it
> >> > should be the device driver core to make sure that dependencies =
are
> >> > ready before probing a device. I gave this idea a try [2] but Ma=
rk Brown
> >> > pointed out to the logic duplication between the resource acquis=
ition
> >> > and dependency discovery code paths (though I think it's fairly =
minor).
> >> >
> >> > To address that code duplication I experimented with Arnd's devm=
_probe
> >> > [3] concept of having drivers declare their dependencies instead=
 of
> >> > acquiring them during probe, and while it worked [4], I don't th=
ink we
> >> > end up winning anything when compared to just probing devices on=
-demand
> >> > from resource getters.
> >> >
> >> > One remaining objection is to the "sprinkling" of calls to
> >> > of_device_probe() in the resource getters of each subsystem, but=
 I think
> >> > it's the right thing to do given that the storage of resources i=
s
> >> > currently subsystem-specific.
> >> >
> >> > We could avoid the above by moving resource storage into the cor=
e, but I
> >> > don't think there's a compelling case for that.
> >> >
> >> > I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip=
 and
> >> > OMAP SoCs, and these patches were enough to eliminate all the de=
ferred
> >> > probes (except one in PandaBoard because omap_dma_system doesn't=
 have a
> >> > firmware node as of yet).
> >> >
> >> > Have submitted a branch [5][6][7] with these patches on top of t=
oday's
> >> > linux-next (20150921) to kernelci.org and I don't see any issues=
 that
> >> > could be caused by them.
> >> >
> >> > With this series I get the kernel to output to the panel in 0.5s=
,
> >> > instead of 2.8s.
> >>
> >> I think we're pretty close other than some minor comments. I would=
 like
> >> to see ack's from Greg and some reviewed-bys from others. The subs=
ystem
> >> changes are minor and there has been plenty of chance to comment, =
so I
> >> don't think acks from all subsystems are needed.
> >>
> >> Your branch is based on -next. Is there any dependence on somethin=
g in
> >> -next? I want to get this into -next soon, but need a branch not b=
ased
> >> on -next. Please send me a pull request with the collected acks an=
d
> >> minor comments I have addressed.
> >
> > Let me review this on Monday and I'll let you know...
>=20
> Hi Greg, hope you don't mind that I ping you regarding this, just in
> case it fell through some crack.

It's on my todo list, sorry, am at a conference for the next few days,
didn't get to it on Monday, hopefully soon...

greg "my todo list is too long" k-h
