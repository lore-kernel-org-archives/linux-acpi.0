From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 5/6] gpio / ACPI: get rid of acpi_gpio.h
Date: Thu, 28 Nov 2013 15:41:31 +0100
Message-ID: <CACRpkdYC3mFKejzLA6HyzJJCMm3mszix1ELOb_6tv6C7FnNazQ@mail.gmail.com>
References: <1385460350-17543-1-git-send-email-mika.westerberg@linux.intel.com>
	<1385460350-17543-6-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1385460350-17543-6-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 26, 2013 at 11:05 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Now that all users of acpi_gpio.h have been moved to use either the GPIO
> descriptor interface or to the internal gpiolib.h we can get rid of
> acpi_gpio.h entirely.
>
> Once this is done the only interface to get GPIOs to drivers enumerated
> from ACPI namespace is the descriptor based interface.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

I must say I really like this patch. This is exactly how we should
proceed with everything also for device tree, getting rid of
<linux/of_gpio.h> - OK maybe some time will be required but
surely we can get there.

I'm giving subsystem maintainers some grace time but this is a
real important series for v3.14.

Yours,
Linus Walleij
