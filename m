From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/4] ACPI / gpio: Add support for naming GPIOs
Date: Thu, 20 Oct 2016 14:02:34 +0200
Message-ID: <CACRpkdazDHGj9J34NYfZLVNfGftSWzf-QMKakJcQSdr3MgGgGw@mail.gmail.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com> <20160929133944.158596-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160929133944.158596-3-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 29, 2016 at 3:39 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> DT has property 'gpio-line-names' to name GPIO lines the controller has if
> present. Use this very same property in ACPI as well to provide nice names
> for the GPIOS.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Looks OK to me, is this patch independent so I can merge it into the
GPIO tree or does it need to go in with patch 1/4 to the ACPI tree?

Yours,
Linus Walleij
