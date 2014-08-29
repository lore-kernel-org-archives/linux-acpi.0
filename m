From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 7/9] gpio: sch: Consolidate core and resume banks
Date: Fri, 29 Aug 2014 08:36:31 +0200
Message-ID: <CACRpkdZr3aLfiD24cpXjtrczvkuCvpfsSv6zadawkQf+v8vsfQ@mail.gmail.com>
References: <1408172039-32513-1-git-send-email-mika.westerberg@linux.intel.com>
	<1408172039-32513-8-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408172039-32513-8-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Darren Hart <dvhart@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Al Stone <al.stone@linaro.org>, Olof Johansson <olof@lixom.net>, Matthew Garrett <matthew.garrett@nebula.com>, Matt Fleming <matt.fleming@intel.com>, David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Josh Triplett <josh@joshtriplett.org>, Aaron Lu <aaron.lu@intel.com>, Max Eliaser <max.eliaser@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Brown <broonie@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>Rob
List-Id: linux-acpi@vger.kernel.org

On Sat, Aug 16, 2014 at 8:53 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> This is actually a single device with two sets of identical registers,
> which just happen to start from a different offset. Instead of having
> separate GPIO chips created we consolidate them to be single GPIO chip.
>
> In addition having a single GPIO chip allows us to handle ACPI GPIO
> translation in the core in a more generic way, since the two GPIO chips
> share the same parent ACPI device.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Max Eliaser <max.eliaser@intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this needs to be merged with the rest of the stuff in this series
so for the GPIO sch part go ahead.

Yours,
Linus Walleij
