From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 5/8] gpio: acpi: Synchronize acpi_find_gpio() and
 acpi_gpio_count()
Date: Fri, 24 Mar 2017 17:55:04 +0200
Message-ID: <20170324155504.GE2957@lahna.fi.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
 <20170323194618.26548-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170323194618.26548-6-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 23, 2017 at 09:46:15PM +0200, Andy Shevchenko wrote:
> If we pass connection ID to the both functions and at the same time
> acpi_can_fallback_to_crs() returns false we will get different results, i.e.
> the number of GPIO resourses returned by acpi_gpio_count() might be not
                     ^^^^^^^^^
resources
