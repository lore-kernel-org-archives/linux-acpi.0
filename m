From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/5] gpiolib / ACPI: move acpi_gpiochip_free_interrupts
 next to the request function
Date: Mon, 14 Oct 2013 08:58:05 +0200
Message-ID: <CACRpkdaVyLwOC-b2mKDRAfCQPzFZKEAm8OZxvHtbpc1koeUz-w@mail.gmail.com>
References: <1381392071-21407-1-git-send-email-mika.westerberg@linux.intel.com>
	<1381392071-21407-2-git-send-email-mika.westerberg@linux.intel.com>
	<CACRpkdZgP9VnVSpBN2Wg4ihL4ryZXeP=ASwr6BCP=u79eg6s6g@mail.gmail.com>
	<CAAVeFu+K6HvQTMOQqMbZPUD_C3nQ1MvYju1BGUOWPYJjQEpTjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAAVeFu+K6HvQTMOQqMbZPUD_C3nQ1MvYju1BGUOWPYJjQEpTjg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2013 at 6:42 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Fri, Oct 11, 2013 at 4:00 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Thu, Oct 10, 2013 at 10:01 AM, Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:
>>
>>> It makes more sense to have these functions close to each other. No
>>> functional changes.
>>>
>>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> So I've applied this first patch, and I'm just waiting for Alexandre's
>> ACK on the remaining patches concerning gpiod so we get this
>> 100% right.
>
> I think I'm ok with Mika's patches, however I need to send you a new
> version of gpiod. I wanted to finish documentation first, but maybe
> that can come slightly after so you can at least go ahead with both
> series?

The important thing right now is to get it in a testable form I think?
So that I can throw it at the autobuilder and it gets included into
linux-next as that comes back online.

So give me whatever you have ... BTW is this series dependent on
yours to go in first? Sorry for not seeing the details here...

Yours,
Linus Walleij
