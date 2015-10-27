From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 03/22] of/platform: Point to struct device from device node
Date: Tue, 27 Oct 2015 16:43:53 +0100
Message-ID: <3956941.s3nuWak5tq@vostro.rjw.lan>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com> <1806288.pmhamH8mKQ@vostro.rjw.lan> <CAAObsKBjNZMhKn2bUMmQO8Lvrqfucnf9dXqmbfQ2DbAc6_GvcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKBjNZMhKn2bUMmQO8Lvrqfucnf9dXqmbfQ2DbAc6_GvcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, October 27, 2015 03:48:40 PM Tomeu Vizoso wrote:
> On 24 October 2015 at 15:57, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

[...]

> >
> > Well, once that has happened, your new device pointer in the given device_node
> > becomes useless.  Why exactly is that fine?
> 
> Why do you think it's useless? It's the device that was registered
> from that device_node. The other one just happens to want to point to
> the same device_node for whatever other reason, but I don't see how is
> that relevant.

It is useless as a reverse mapping from OF nodes to devices.  It tells us
which device pointing to the given device node has been found first, but
that's just it.

You can't say whether or not it is special in any way with respect to the
other devices hanging out of the same OF node unless you have some additional
information on how those devices are related to each other.

Thanks,
Rafael
