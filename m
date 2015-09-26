From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v6 0/22] On-demand device probing
Date: Sat, 26 Sep 2015 12:22:18 -0700
Message-ID: <20150926192218.GA15657@kroah.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <5606E120.3070305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5606E120.3070305-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Sep 26, 2015 at 01:17:04PM -0500, Rob Herring wrote:
> On 09/21/2015 09:02 AM, Tomeu Vizoso wrote:
> > Hello,
> >=20
> > I have a problem with the panel on my Tegra Chromebook taking longe=
r
> > than expected to be ready during boot (St=E9phane Marchesin reporte=
d what
> > is basically the same issue in [0]), and have looked into ordered
> > probing as a better way of solving this than moving nodes around in=
 the
> > DT or playing with initcall levels and linking order.
> >=20
> > While reading the thread [1] that Alexander Holler started with his
> > series to make probing order deterministic, it occurred to me that =
it
> > should be possible to achieve the same by probing devices as they a=
re
> > referenced by other devices.
> >=20
> > This basically reuses the information that is already implicit in t=
he
> > probe() implementations, saving us from refactoring existing driver=
s or
> > adding information to DTBs.
> >=20
> > During review of v1 of this series Linus Walleij suggested that it
> > should be the device driver core to make sure that dependencies are
> > ready before probing a device. I gave this idea a try [2] but Mark =
Brown
> > pointed out to the logic duplication between the resource acquisiti=
on
> > and dependency discovery code paths (though I think it's fairly min=
or).
> >=20
> > To address that code duplication I experimented with Arnd's devm_pr=
obe
> > [3] concept of having drivers declare their dependencies instead of
> > acquiring them during probe, and while it worked [4], I don't think=
 we
> > end up winning anything when compared to just probing devices on-de=
mand
> > from resource getters.
> >=20
> > One remaining objection is to the "sprinkling" of calls to
> > of_device_probe() in the resource getters of each subsystem, but I =
think
> > it's the right thing to do given that the storage of resources is
> > currently subsystem-specific.
> >=20
> > We could avoid the above by moving resource storage into the core, =
but I
> > don't think there's a compelling case for that.
> >=20
> > I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip an=
d
> > OMAP SoCs, and these patches were enough to eliminate all the defer=
red
> > probes (except one in PandaBoard because omap_dma_system doesn't ha=
ve a
> > firmware node as of yet).
> >=20
> > Have submitted a branch [5][6][7] with these patches on top of toda=
y's
> > linux-next (20150921) to kernelci.org and I don't see any issues th=
at
> > could be caused by them.
> >=20
> > With this series I get the kernel to output to the panel in 0.5s,
> > instead of 2.8s.
>=20
> I think we're pretty close other than some minor comments. I would li=
ke
> to see ack's from Greg and some reviewed-bys from others. The subsyst=
em
> changes are minor and there has been plenty of chance to comment, so =
I
> don't think acks from all subsystems are needed.
>=20
> Your branch is based on -next. Is there any dependence on something i=
n
> -next? I want to get this into -next soon, but need a branch not base=
d
> on -next. Please send me a pull request with the collected acks and
> minor comments I have addressed.

Let me review this on Monday and I'll let you know...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
