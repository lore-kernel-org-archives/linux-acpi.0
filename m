From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI: bus.c: Let acpi_device_get_match_data() return DT compatibility data
Date: Mon, 09 Jul 2018 11:20:16 +0200
Message-ID: <18030756.yHdBu7e6UJ@aspire.rjw.lan>
References: <950e8d0caf9f5f55df07eba8a11b2fa8cba9f9e1.1530708691.git.nikolaus.voss@loewensteinmedical.de> <CAHp75Vd2u9o50h3VQQrJZfu6fYhxydG4gRD4U5u+LuxTUScSwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd2u9o50h3VQQrJZfu6fYhxydG4gRD4U5u+LuxTUScSwQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolaus Voss <nv@vosn.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Len Brown <lenb@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Xiongfeng Wang <xiongfeng.wang@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Ray Jui <ray.jui@broadcom.com>, Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>, Vikram Prakash <vikram.prakash@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, Srinath Mannam <srinath.mannam@broadcom.com>, Nikolaus Voss <nikolau>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, July 4, 2018 4:40:34 PM CEST Andy Shevchenko wrote:
> On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss <nv@vosn.de> wrote:
> > When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
> > of_device_id table "compatible" strings in DSD, a pointer to the
> > corresponding DT table entry should be returned instead of a null
> > pointer. An acpi_device_id match still takes precedence.
> >
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> with a caveat that this is only an improvement for a _temporary_
> PRP0001 users like I2C or SPI slave devices.
> Please, don't consider this change as a valid point to (ab)use PRP0001
> in a cases where devices are not "hotpluggable".
> 
> > v2: improve readability (as suggested by Andy Shevchenko)
> >
> > Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Nikolaus, please resend the v2 with the Andy's tag to linux-acpi@gver.kernel.org

It won't be applied otherwise.

Thanks,
Rafael
