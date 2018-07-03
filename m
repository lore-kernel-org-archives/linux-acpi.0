From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ACPI: bus.c: Let acpi_device_get_match_data() return DT
 compatibility data
Date: Wed, 4 Jul 2018 01:31:26 +0300
Message-ID: <CAHp75VeKbXA1wtJr_u0y+Ndjouf2GH51UHsLcsC6s32kWtA3zw@mail.gmail.com>
References: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vdn-Fn_bwgBjvnLa_s2LORgdEjLH0jpRvVDjwyxKOLEBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdn-Fn_bwgBjvnLa_s2LORgdEjLH0jpRvVDjwyxKOLEBw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 4, 2018 at 12:31 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
>> of_device_id table "compatible" strings in DSD, a pointer to the
>> corresponding DT table entry should be returned instead of a null
>> pointer. An acpi_device_id match still takes precedence.
>
> I'm not sure what you are trying to achieve here.
> This works solely for ACPI case.

Okay, now, after a bit of browsing sources, I got your problem.
Indeed, we have acpi_of_match_device() which returns matched OF item,
but no caller is interested in it...


-- 
With Best Regards,
Andy Shevchenko
