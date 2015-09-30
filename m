From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v6 0/22] On-demand device probing
Date: Wed, 30 Sep 2015 12:09:27 +0200
Message-ID: <CAAObsKChqEfFO+qTwLcBLs8tPPT_gchGKK287652jdC=5R6+qQ@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <5606E120.3070305@kernel.org> <20150926192218.GA15657@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150926192218.GA15657-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 26 September 2015 at 21:22, Greg Kroah-Hartman
<gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Sat, Sep 26, 2015 at 01:17:04PM -0500, Rob Herring wrote:
>> On 09/21/2015 09:02 AM, Tomeu Vizoso wrote:
>> > Hello,
>> >
>> > I have a problem with the panel on my Tegra Chromebook taking long=
er
>> > than expected to be ready during boot (St=C3=A9phane Marchesin rep=
orted what
>> > is basically the same issue in [0]), and have looked into ordered
>> > probing as a better way of solving this than moving nodes around i=
n the
>> > DT or playing with initcall levels and linking order.
>> >
>> > While reading the thread [1] that Alexander Holler started with hi=
s
>> > series to make probing order deterministic, it occurred to me that=
 it
>> > should be possible to achieve the same by probing devices as they =
are
>> > referenced by other devices.
>> >
>> > This basically reuses the information that is already implicit in =
the
>> > probe() implementations, saving us from refactoring existing drive=
rs or
>> > adding information to DTBs.
>> >
>> > During review of v1 of this series Linus Walleij suggested that it
>> > should be the device driver core to make sure that dependencies ar=
e
>> > ready before probing a device. I gave this idea a try [2] but Mark=
 Brown
>> > pointed out to the logic duplication between the resource acquisit=
ion
>> > and dependency discovery code paths (though I think it's fairly mi=
nor).
>> >
>> > To address that code duplication I experimented with Arnd's devm_p=
robe
>> > [3] concept of having drivers declare their dependencies instead o=
f
>> > acquiring them during probe, and while it worked [4], I don't thin=
k we
>> > end up winning anything when compared to just probing devices on-d=
emand
>> > from resource getters.
>> >
>> > One remaining objection is to the "sprinkling" of calls to
>> > of_device_probe() in the resource getters of each subsystem, but I=
 think
>> > it's the right thing to do given that the storage of resources is
>> > currently subsystem-specific.
>> >
>> > We could avoid the above by moving resource storage into the core,=
 but I
>> > don't think there's a compelling case for that.
>> >
>> > I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip a=
nd
>> > OMAP SoCs, and these patches were enough to eliminate all the defe=
rred
>> > probes (except one in PandaBoard because omap_dma_system doesn't h=
ave a
>> > firmware node as of yet).
>> >
>> > Have submitted a branch [5][6][7] with these patches on top of tod=
ay's
>> > linux-next (20150921) to kernelci.org and I don't see any issues t=
hat
>> > could be caused by them.
>> >
>> > With this series I get the kernel to output to the panel in 0.5s,
>> > instead of 2.8s.
>>
>> I think we're pretty close other than some minor comments. I would l=
ike
>> to see ack's from Greg and some reviewed-bys from others. The subsys=
tem
>> changes are minor and there has been plenty of chance to comment, so=
 I
>> don't think acks from all subsystems are needed.
>>
>> Your branch is based on -next. Is there any dependence on something =
in
>> -next? I want to get this into -next soon, but need a branch not bas=
ed
>> on -next. Please send me a pull request with the collected acks and
>> minor comments I have addressed.
>
> Let me review this on Monday and I'll let you know...

Hi Greg, hope you don't mind that I ping you regarding this, just in
case it fell through some crack.

Regards,

Tomeu

> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
