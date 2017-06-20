From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/3] gpio: Add support for TPS68470 GPIOs
Date: Tue, 20 Jun 2017 10:52:56 +0200
Message-ID: <CACRpkdZU2kuBGh84DL8naHitoj3Y-pFXLyw5vec36fWMHLnyQA@mail.gmail.com>
References: <1497259612-38401-1-git-send-email-rajmohan.mani@intel.com> <1497259612-38401-3-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1497259612-38401-3-git-send-email-rajmohan.mani@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 12, 2017 at 11:26 AM, Rajmohan Mani <rajmohan.mani@intel.com> wrote:

> This patch adds support for TPS68470 GPIOs.
> There are 7 GPIOs and a few sensor related GPIOs.
> These GPIOs can be requested and configured as
> appropriate.
>
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>

This is some fine code.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Feel free to merge this through MFD or tell me if I should
merge it if there are no compile-time dependencies.

Yours,
Linus Walleij
