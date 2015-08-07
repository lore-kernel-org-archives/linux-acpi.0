From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 01/18] platform: delay OF device-driver matches until
 late_initcall
Date: Fri, 7 Aug 2015 20:06:31 +0300
Message-ID: <55C4E597.1010701@ti.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com> <1438870315-18689-2-git-send-email-tomeu.vizoso@collabora.com> <CAL_Jsq+GLMZe-f6qEi=7i1YrrWc6k99RpGkOyCd5KkYDiyt0QA@mail.gmail.com> <CAAObsKBapFqzr+4YEXJfcJWMd+tkaBqYbGiFTntHStAP=+P-_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKBapFqzr+4YEXJfcJWMd+tkaBqYbGiFTntHStAP=+P-_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Rob Herring <robherring2@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On 08/07/2015 10:11 AM, Tomeu Vizoso wrote:
> On 6 August 2015 at 22:19, Rob Herring <robherring2@gmail.com> wrote:
>> On Thu, Aug 6, 2015 at 9:11 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>>> Delay matches of platform devices with OF nodes until late_initcall,
>>> when we are sure that all built-in drivers have been registered already.
>>> This is needed to prevent deferred probes because of some drivers not
>>> having registered yet.
>>>
>>> The reason why only platform devices are delayed is that some other
>>> devices are expected to be probed earlier than late_initcall, for
>>> example, the system PNP driver needs to probe its devices in
>>> fs_initcall.
>>>
>>> Additionally, only platform devices with OF nodes are delayed because
>>> some machines may depend on oter platform devices being registered at
>>> specific times.
>>
>> How do we know that these probes occur before the unused clocks and
>> regulators are turned off? Just getting lucky (as is deferred probe)?
>> Can we do this one level earlier so we have a level left to do things
>> after probe.
> 
> Those are already late_initcall_sync so I guess we're fine.

I wouldn't be so sure :(
FYI:
http://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/763d643bbfc0f445c6685c541fcae3c370e4314a


-- 
regards,
-grygorii
