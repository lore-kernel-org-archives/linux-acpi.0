From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v3 01/18] platform: delay OF device-driver matches until late_initcall
Date: Sun, 9 Aug 2015 15:03:14 +0200
Message-ID: <CAAObsKDJsuhuQfLbxq27Mtm1T_Auz7Gohp8PDyK7rNNDyaGhcg@mail.gmail.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-2-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+GLMZe-f6qEi=7i1YrrWc6k99RpGkOyCd5KkYDiyt0QA@mail.gmail.com>
 <CAAObsKBapFqzr+4YEXJfcJWMd+tkaBqYbGiFTntHStAP=+P-_Q@mail.gmail.com> <55C4E597.1010701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C4E597.1010701@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Rob Herring <robherring2@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On 7 August 2015 at 19:06, Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> On 08/07/2015 10:11 AM, Tomeu Vizoso wrote:
>> On 6 August 2015 at 22:19, Rob Herring <robherring2@gmail.com> wrote:
>>> On Thu, Aug 6, 2015 at 9:11 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>>>> Delay matches of platform devices with OF nodes until late_initcall,
>>>> when we are sure that all built-in drivers have been registered already.
>>>> This is needed to prevent deferred probes because of some drivers not
>>>> having registered yet.
>>>>
>>>> The reason why only platform devices are delayed is that some other
>>>> devices are expected to be probed earlier than late_initcall, for
>>>> example, the system PNP driver needs to probe its devices in
>>>> fs_initcall.
>>>>
>>>> Additionally, only platform devices with OF nodes are delayed because
>>>> some machines may depend on oter platform devices being registered at
>>>> specific times.
>>>
>>> How do we know that these probes occur before the unused clocks and
>>> regulators are turned off? Just getting lucky (as is deferred probe)?
>>> Can we do this one level earlier so we have a level left to do things
>>> after probe.
>>
>> Those are already late_initcall_sync so I guess we're fine.
>
> I wouldn't be so sure :(
> FYI:
> http://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/763d643bbfc0f445c6685c541fcae3c370e4314a

If I understand the situation correctly, this is one more instance of
starting to do some work at some point and hoping that something else
that started before has already finished happening. If that's the
case, how does this series make that worst?

During this development I have found many hacks intended to put some
order, even if not enough care was taken to make sure that the order
was guaranteed. In general I would recommend for moving code into
proper drivers and have them to defer the probe of their devices if
some dependency isn't fulfilled at that moment.

Once that's done and we have a safe and reliable boot, we can avoid
those deferred probes by fulfilling the dependency on-demand as this
series shows.

There was some recent thread about how the disabling of unused clocks
and regulators isn't really safe because after late_initcall_sync more
drivers can be registered from modules. Furthermore, there's async
device probes.

Regards,

Tomeu

>
> --
> regards,
> -grygorii
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
