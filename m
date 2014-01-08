From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 2/4] mmc: sdhci-acpi: convert to use GPIO descriptor API
Date: Wed, 8 Jan 2014 12:54:13 +0100
Message-ID: <CACRpkdYhynQ4ooHcZyc-nrgVK9gbvtsYR6ZVv1u0sfBVEaK93A@mail.gmail.com>
References: <1389177657-29266-1-git-send-email-mika.westerberg@linux.intel.com>
	<1389177657-29266-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1389177657-29266-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 8, 2014 at 11:40 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> The new descriptor based GPIO interface is now the recommended and safer
> way of using GPIOs from device drivers. Convert the ACPI SDHCI driver to
> use that interface.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

I've tentatively applied this to the GPIO tree now, as it was acked by
Adrian who is a long time MMC subsystem contributor and we need
it to proceed with the rest of the refactorings.

Chris, beat me up if you're unhappy with this.

(If it explodes in linux-next I'll just back it all out.)

Yours,
Linus Walleij
