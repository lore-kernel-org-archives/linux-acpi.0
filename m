From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 1/6] ARM: tegra: add gpiod_lookup table for paz00
Date: Tue, 26 Nov 2013 13:33:09 -0700
Message-ID: <52950585.2080802@wwwdotorg.org>
References: <1385460350-17543-1-git-send-email-mika.westerberg@linux.intel.com> <1385460350-17543-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1385460350-17543-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 11/26/2013 03:05 AM, Mika Westerberg wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> This makes it possible to request the gpio descriptors in
> rfkill_gpio driver regardless of the platform.

V2 of the series did the following:

 static struct rfkill_gpio_platform_data wifi_rfkill_platform_data = {
 	.name		= "wifi_rfkill",
-	.reset_gpio	= 25, /* PD1 */
-	.shutdown_gpio	= 85, /* PK5 */
 	.type	= RFKILL_TYPE_WLAN,
 };

I assume that will happen sometime, along with removing those two fields
from the struct definition.
