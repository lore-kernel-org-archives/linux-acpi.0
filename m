From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v5 07/23] regulator: core: Remove regulator_list
Date: Mon, 21 Sep 2015 16:08:05 +0200
Message-ID: <CAAObsKC598mDK3n_1oYJHDTq_dyq4gC+3TEMogOGijbhY7+W3A@mail.gmail.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442494637-3674-8-git-send-email-tomeu.vizoso@collabora.com> <20150919150129.GR12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150919150129.GR12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-acpi@vger.kernel.org

On 19 September 2015 at 17:01, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 17, 2015 at 02:57:01PM +0200, Tomeu Vizoso wrote:
>> As we are already registering a device with regulator_class for each
>> regulator device, regulator_list is redundant and can be replaced with
>> calls to class_find_device() and class_for_each_device().
>
> This appears to leak references to the struct devices returned by
> class_find_device() - it takes a reference before it returns so any
> device found using class_find_device() needs to be released with
> put_device() and I don't see any new put_device() calls in here.

You are right, I have merged the subsequent patch into this one so no
refs are leaked in between.

Thanks,

Tomeu

>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>
> This is not the case at all, this patch was newly added.  If you want
> to include changelogs like this in the patch description try to ensure
> that they bear some relationship to reality, if they don't they are
> actively harmful as they are likely to mislead or annoy the reader.
