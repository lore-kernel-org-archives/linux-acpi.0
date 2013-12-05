From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and
 its related head file
Date: Thu, 05 Dec 2013 21:51:39 +0800
Message-ID: <52A084EB.5010103@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org> <201312050438.05117.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201312050438.05117.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, patches@linaro.org, Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Jon Masters <jonathan@jonmasters.org>, Grant Likely <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

On 2013=E5=B9=B412=E6=9C=8805=E6=97=A5 11:38, Arnd Bergmann wrote:
> On Tuesday 03 December 2013, Hanjun Guo wrote:
>> +static unsigned int gsi_to_irq(unsigned int gsi)
>> +{
>> +       int irq =3D irq_create_mapping(NULL, gsi);
>> +
>> +       return irq;
>> +}
> I think this could use a comment regarding your plans for IRQ domains=
=2E
>
> Do you expect that all ACPI systems would have only a single GIC IRQ
> controller and a single domain, or do you plan to add irqdomain code
> later?

we added irqdomain code in the part2 patch set, is that the code ok
with you?

Thanks
Hanjun
