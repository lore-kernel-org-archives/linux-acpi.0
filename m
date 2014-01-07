From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 3/6] mmc: sdhci-acpi: convert to use GPIO descriptor API
Date: Tue, 7 Jan 2014 18:47:23 +0100
Message-ID: <CACRpkdbkntK0_PzWiEXg+nAfHXpTraEq_9tEkBpcuk_ZxyoQkA@mail.gmail.com>
References: <1385460350-17543-1-git-send-email-mika.westerberg@linux.intel.com>
	<1385460350-17543-4-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1385460350-17543-4-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 26, 2013 at 11:05 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> The new descriptor based GPIO interface is now the recommended and safer
> way of using GPIOs from device drivers. Convert the ACPI SDHCI driver to
> use that interface.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Chris, can I have your ACK on this patch?

Yours,
Linus Walleij
