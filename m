From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 1/4] pinctrl: Rename pinctrl_utils_dt_free_map to pinctrl_utils_free_map
Date: Fri, 1 Apr 2016 15:08:32 +0200
Message-ID: <CACRpkdb4bKoWMxAo4H1ycy5gk1Rh9jC=TPXJ4ycnfPh6LWEOyQ@mail.gmail.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	<1459424685-26965-2-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459424685-26965-2-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 31, 2016 at 1:44 PM, Irina Tirdea <irina.tirdea@intel.com> wrote:

> Rename pinctrl_utils_dt_free_map to pinctrl_utils_free_map, since
> it does not depend on device tree despite the current name. This
> will enforce a consistent naming in pinctr-utils.c and will make
> it clear it can be called from outside device tree (e.g. from
> ACPI handling code).
>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

OK that's a good change making nice ground work for the rest.
Patch applied.

For the rest I want to hear from Rafael and/or Mika first.

Yours,
Linus Walleij
