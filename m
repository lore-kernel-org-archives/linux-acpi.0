From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH][next] gpiolib-acpi: remove unused variable 'err', cleans
 up build warning
Date: Fri, 21 Dec 2018 11:31:24 +0100
Message-ID: <CACRpkdZn_s6LHeqTZqEMhzpY=u2jcda_YUvnfX0qwEw8kMWJOw@mail.gmail.com>
References: <20181218122802.28157-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218122802.28157-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, kernel-janitors@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 18, 2018 at 1:28 PM Colin King <colin.king@canonical.com> wrote=
:

> From: Colin Ian King <colin.king@canonical.com>
>
> Variable err is defined but never used. Remove it. Cleans up warning:
>
> warning: unused variable =E2=80=98err=E2=80=99 [-Wunused-variable]
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
