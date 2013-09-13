From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] gpio / ACPI: add support for GPIO operation regions
Date: Fri, 13 Sep 2013 18:55:11 +0300
Message-ID: <CAHp75Vcec5MiGMUiusJhAmG6-R63OUZSXZPzafJzP6dC13Dgnw@mail.gmail.com>
References: <1379085280-2211-1-git-send-email-mika.westerberg@linux.intel.com>
	<1379085280-2211-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379085280-2211-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 13, 2013 at 6:14 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> GPIO operation regions is a new feature introduced in ACPI 5.0
> specification. In practise it means that now ASL code can toggle GPIOs with
> the help of the OS GPIO driver.

[]

>  void acpi_gpiochip_add(struct gpio_chip *chip)
>  {
> +       struct acpi_gpio_chip_data *data;
> +       acpi_handle handle;
> +       acpi_status status;
> +
> +       handle = ACPI_HANDLE(chip->dev);
> +       if (!handle)
> +               return;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);

May we use devm_kzalloc here?

-- 
With Best Regards,
Andy Shevchenko
