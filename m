From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 0/22] On-demand device probing
Date: Tue, 13 Oct 2015 16:21:41 -0500
Message-ID: <CAL_JsqLhHm4k8uS56qRGoNyLFKZh_e6U3PL-cu=fcWgVv54v=g@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <5606E120.3070305@kernel.org> <CAAObsKDffo935Ae3wEPVAFyqBDR+d6LKmh0ORfmYGnu2DN7YEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKDffo935Ae3wEPVAFyqBDR+d6LKmh0ORfmYGnu2DN7YEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 13, 2015 at 2:57 PM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> On 26 September 2015 at 20:17, Rob Herring <robh@kernel.org> wrote:
>> On 09/21/2015 09:02 AM, Tomeu Vizoso wrote:
>>> Hello,
>>>
>>> I have a problem with the panel on my Tegra Chromebook taking longe=
r
>>> than expected to be ready during boot (St=C3=A9phane Marchesin repo=
rted what
>>> is basically the same issue in [0]), and have looked into ordered
>>> probing as a better way of solving this than moving nodes around in=
 the
>>> DT or playing with initcall levels and linking order.
>>>
>>> While reading the thread [1] that Alexander Holler started with his
>>> series to make probing order deterministic, it occurred to me that =
it
>>> should be possible to achieve the same by probing devices as they a=
re
>>> referenced by other devices.
>>>
>>> This basically reuses the information that is already implicit in t=
he
>>> probe() implementations, saving us from refactoring existing driver=
s or
>>> adding information to DTBs.
>>>
>>> During review of v1 of this series Linus Walleij suggested that it
>>> should be the device driver core to make sure that dependencies are
>>> ready before probing a device. I gave this idea a try [2] but Mark =
Brown
>>> pointed out to the logic duplication between the resource acquisiti=
on
>>> and dependency discovery code paths (though I think it's fairly min=
or).
>>>
>>> To address that code duplication I experimented with Arnd's devm_pr=
obe
>>> [3] concept of having drivers declare their dependencies instead of
>>> acquiring them during probe, and while it worked [4], I don't think=
 we
>>> end up winning anything when compared to just probing devices on-de=
mand
>>> from resource getters.
>>>
>>> One remaining objection is to the "sprinkling" of calls to
>>> of_device_probe() in the resource getters of each subsystem, but I =
think
>>> it's the right thing to do given that the storage of resources is
>>> currently subsystem-specific.
>>>
>>> We could avoid the above by moving resource storage into the core, =
but I
>>> don't think there's a compelling case for that.
>>>
>>> I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip an=
d
>>> OMAP SoCs, and these patches were enough to eliminate all the defer=
red
>>> probes (except one in PandaBoard because omap_dma_system doesn't ha=
ve a
>>> firmware node as of yet).
>>>
>>> Have submitted a branch [5][6][7] with these patches on top of toda=
y's
>>> linux-next (20150921) to kernelci.org and I don't see any issues th=
at
>>> could be caused by them.
>>>
>>> With this series I get the kernel to output to the panel in 0.5s,
>>> instead of 2.8s.
>>
>> I think we're pretty close other than some minor comments. I would l=
ike
>> to see ack's from Greg and some reviewed-bys from others. The subsys=
tem
>> changes are minor and there has been plenty of chance to comment, so=
 I
>> don't think acks from all subsystems are needed.
>
> Hi Rob,
>
> I'm not sure we are going to get much more feedback by just waiting o=
r
> resending what has been sent so many times.

Agreed.

> Did you have in mind specific people you wanted to see reviewed-bys f=
rom?

Mainly Greg.

Please send me a pull req. I want to get this into -next and can
always drop it if there is further review.

Rob
