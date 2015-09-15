From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v4 21/22] driver core: Start processing deferred probes earlier
Date: Tue, 15 Sep 2015 15:16:12 +0200
Message-ID: <CAAObsKCOZ3TkQB6oKt+UmBSvUoM-kXT0Rs=FaFKs8bY76065LA@mail.gmail.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-22-git-send-email-tomeu.vizoso@collabora.com> <20150911122423.GS12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150911122423.GS12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

On 11 September 2015 at 14:24, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Sep 07, 2015 at 02:23:46PM +0200, Tomeu Vizoso wrote:
>> Some initcalls in the late level assume that some devices will have
>> already probed without explicitly checking for that.
>>
>> After the recent move to defer most device probes when they are
>> registered, pressure increased in the late initcall level.
>>
>> By starting the processing of the deferred queue in device_initcall_sync
>> we increase the chances that the initcalls mentioned before will find
>> the devices they depend on to have already probed.
>
> Which cases do we have that are outside the driver model and thus
> affected by this?  USB gadgets are one case I'm aware of, and cpufreq is
> still problematic.  I'm wondering if it might be tractable to address
> the actual problems with the remaining reliance on init ordering here.

Actually, I don't know of any specific case that needs this commit.
The present series without this patch passes on all the boards in
kernelci, but Grygorii Strashko argued for it during the review of the
earlier version of this series:
http://lkml.kernel.org/g/55CE3D04.8000607@ti.com

IMO it would be better to not apply this patch until the need arises,
and even then, it may be better to make the dependencies explicit
instead of relying on implicit ordering and messing with the link
order.

> I'm also wondering if we might end up running into situations where this
> makes the problem with havinng to defer probes more of an issue on some
> systems - since we start trying earlier while we are still doing our
> first pass initialisation we could end up deferring some device then
> retrying it a bunch of times while going through the earlier phases of
> init as we continue to register more devices.

With the rest of the series this shouldn't happen as all/most deferred
probes should be avoided.

Regards,

Tomeu
