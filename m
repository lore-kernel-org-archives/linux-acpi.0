From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 3/3] gpio: dwapb: add gpio-signaled acpi event support
Date: Mon, 11 Apr 2016 15:00:35 +0200
Message-ID: <CACRpkdYRRVDZP02GPoFk+jEBYDNiDucB5LpEBRB-O9KAkLu06g@mail.gmail.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
	<1459926480-32966-4-git-send-email-qiujiang@huawei.com>
	<CACRpkdb63AZtEOSJ0R+EqdHfKXcUr7Hs8fh9N5XHNcWjQ1Ba8A@mail.gmail.com>
	<20160408083830.GT1727@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160408083830.GT1727@lahna.fi.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: qiujiang <qiujiang@huawei.com>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 8, 2016 at 10:38 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Calling acpi_gpiochip_request_interrupts() results _AEI ACPI method
> being evaluated that returns a list of GPIOs which are used as event
> sources. acpi_gpiochip_request_interrupts() then goes and installs
> interrupt handler per each GPIO in that list.

Aha OK I see. Thanks for explaining!

Yours,
Linus Walleij
