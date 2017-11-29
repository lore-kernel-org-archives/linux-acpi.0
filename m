From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] pinctrl: intel: Allow custom GPIO base for pad groups
Date: Wed, 29 Nov 2017 13:46:01 +0100
Message-ID: <CACRpkdaZn2or96Ho5mkmC8HsubkeuvVeRt7XVPWR9C65jkM2Ow@mail.gmail.com>
References: <20171127135444.66735-1-mika.westerberg@linux.intel.com> <20171127135444.66735-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171127135444.66735-3-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 27, 2017 at 2:54 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Currently we always have direct mapping between GPIO numbers and the
> hardware pin numbers. However, there are cases where that's not the case
> anymore (more about this in the next patch). Instead we need to be able
> to specify custom GPIO base for certain pad groups.
>
> To support this, add a new field (gpio_base) to the pad group structure
> and update the core Intel pinctrl driver to handle this accordingly.
> Passing 0 as gpio_base will use direct mapping so the existing drivers
> do not need to be modified. Passing -1 excludes the whole pad group from
> having GPIO mapping.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied with Andy's ACK.

Yours,
Linus Walleij
