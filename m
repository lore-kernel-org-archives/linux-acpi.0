From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v2 4/7] mmc: sdhci-acpi: covert to use GPIO descriptor API
Date: Sat, 23 Nov 2013 18:23:34 +0900
Message-ID: <CAAVeFuJHFHfdt1n4j7+iAn7hJGcOaZNvKWmTv4r8E3n4gVTPUg@mail.gmail.com>
References: <1385122474-14926-1-git-send-email-mika.westerberg@linux.intel.com>
 <1385122474-14926-5-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1385122474-14926-5-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 22, 2013 at 9:14 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> The new descriptor based GPIO interface is now the recommended and safer
> way of using GPIOs from device drivers. Convert the ACPI SDHCI driver to
> use that interface.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
