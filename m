From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] Documentation: gpio: Update ACPI part of the document
 to mention _DSD
Date: Wed, 8 Apr 2015 16:47:17 +0200
Message-ID: <CACRpkdYHtW1=0ZObW+WngJ=ONAVXRyRLRFpyveLg93R=4fQ2Hg@mail.gmail.com>
References: <1427875996-216926-1-git-send-email-mika.westerberg@linux.intel.com>
	<20150404112757.04d9f5fd@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150404112757.04d9f5fd@lwn.net>
Sender: linux-gpio-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Darren Hart <dvhart@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Apr 4, 2015 at 11:27 AM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Wed,  1 Apr 2015 11:13:16 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
>
>> With ACPI 5.1 _DSD (Device Specific Data) it is now possible to name
>> functions just like Device Tree is doing. Make sure that the documentation
>> mentions _DSD as the recommended way to describe GPIOs in ACPI systems.
>
> OK, I've applied this to the docs tree, thanks.

Aha Jon takes it, thx, Acked-by.

Yours,
Linus Walleij
