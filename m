From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] gpio / ACPI: Two minor cleanups related to ACPI_HANDLE()
Date: Wed, 18 Mar 2015 02:37:06 +0100
Message-ID: <3557241.dRi1Xkn3WC@vostro.rjw.lan>
References: <4032246.STUT1iRmIk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <4032246.STUT1iRmIk@vostro.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, March 10, 2015 11:07:36 PM Rafael J. Wysocki wrote:
> Hi,
> 
> As per the subject, avoid evaluating ACPI_HANDLE() if we can as that one is
> rather costly.

Linus, Alexandre, any objections to this series?

If not, would there be any problem if I took these to my tree?  I'll probably
have material on top of them.

Rafael

