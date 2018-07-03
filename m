From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ACPI: bus.c: Let acpi_device_get_match_data() return DT
 compatibility data
Date: Wed, 4 Jul 2018 00:31:18 +0300
Message-ID: <CAHp75Vdn-Fn_bwgBjvnLa_s2LORgdEjLH0jpRvVDjwyxKOLEBw@mail.gmail.com>
References: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
> of_device_id table "compatible" strings in DSD, a pointer to the
> corresponding DT table entry should be returned instead of a null
> pointer. An acpi_device_id match still takes precedence.

I'm not sure what you are trying to achieve here.
This works solely for ACPI case.
For PRP0001 (which is just a _temporary_ solution for device in
question) we have special code path in SPI and I2C cores.

https://elixir.bootlin.com/linux/v4.18-rc3/ident/acpi_driver_match_device


-- 
With Best Regards,
Andy Shevchenko
