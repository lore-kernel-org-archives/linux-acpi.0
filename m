From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC part2 PATCH 7/9] irqdomain: Add a new API irq_create_acpi_mapping()
Date: Tue, 10 Dec 2013 11:06:22 +0100
Message-ID: <CACRpkdbQo2yTvaaEeXnje41UZYoWudL731KcjjwYXVyip=iifA@mail.gmail.com>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
	<1386088753-2850-8-git-send-email-hanjun.guo@linaro.org>
	<CAL_JsqK93mJbFu+GaK_5L14jKnMgctUNdEBqS6K5zKer16Sm3Q@mail.gmail.com>
	<529F4C90.4070402@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <529F4C90.4070402@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linaro Patches <patches@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 4, 2013 at 4:38 PM, Hanjun Guo <hanjun.guo@linaro.org> wrot=
e:
> On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 01:25, Rob Herring wrote:
>> On Tue, Dec 3, 2013 at 10:39 AM, Hanjun Guo <hanjun.guo@linaro.org> =
wrote:
>>>
>>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>
>>> This patch introduces a new API for acpi based irq mapping.
>>>
>>> [hanjun: Rework this patch to delete the reference to
>>> gic_irq_domain_xlate() which can simplify the code a lot.]
>>>
>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
(...)
>>> +EXPORT_SYMBOL_GPL(irq_create_acpi_mapping);
>>
>> There is nothing ACPI specific about this function. This is simply
>> irq_create_of_mapping w/o translating of_phandle_args to a hwirq and
>> type. So I expect the code to be re-factored here to mirror that.
>
> Sorry for my bad english, do you mean create a OF free function
> and call that from the OF function ?

Sounds like a good idea, like if you move the OF function into
kernel/irq/irqdomain.c and get rid of the OF specific naming
then use that same function from ACPI too. It's all about
using the irq_default_domain in a standard way after all right?

Yours,
Linus Walleij
