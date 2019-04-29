From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] gpio: sch: Add interrupt support
Date: Mon, 29 Apr 2019 16:19:00 +0300
Message-ID: <20190429131900.GD9224@smile.fi.intel.com>
References: <046793ee-ba51-6a1b-1aa5-14560d849df7@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <046793ee-ba51-6a1b-1aa5-14560d849df7@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J., Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 29, 2019 at 07:55:52AM +0200, Jan Kiszka wrote:
> Validated on the Quark platform, this adds interrupt support on rising
> and/or falling edges.

Can we split it to two:
- Add IRQ support on edge
- Add ACPI handler (with explanation in the commit message why we do like this,
  based on the thread from v1)

?


-- 
With Best Regards,
Andy Shevchenko
