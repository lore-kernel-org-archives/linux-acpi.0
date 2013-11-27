From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v3 2/6] net: rfkill: gpio: convert to descriptor-based
 GPIO interface
Date: Wed, 27 Nov 2013 11:30:20 +0900
Message-ID: <5295593C.309@nvidia.com>
References: <1385460350-17543-1-git-send-email-mika.westerberg@linux.intel.com> <1385460350-17543-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385460350-17543-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 11/26/2013 07:05 PM, Mika Westerberg wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> Convert to the safer gpiod_* family of API functions.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
