From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation
 region driver
Date: Wed, 7 Jun 2017 15:15:04 +0300
Message-ID: <20170607121503.GA1019@valkosipuli.retiisi.org.uk>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VcvV_AbLJCq9Rm_8yab3nViPm6ikxxme4oyw9vm4Kz7Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcvV_AbLJCq9Rm_8yab3nViPm6ikxxme4oyw9vm4Kz7Gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 06, 2017 at 05:23:56PM +0300, Andy Shevchenko wrote:
> Follow the pattern, please, I suppose
> ti_pmic_tps68470.c

This pattern is weird. "ti" in front of the file name is redundant, and in
very few places the vendor prefix is used anyway. Especially when the chip
has a proper name --- as this one does.

I assume for the Intel PMICs it could be there for a couple of reasons which
are

1) lack of a clearly unique chip ID and

2) the use of common frameworklet for Intel PMICs.

There are also no other PMIC chips supported currently.

The pmic_tps68470 naming is in line with the GPIO driver (apart from the
dash / underscore difference).

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
