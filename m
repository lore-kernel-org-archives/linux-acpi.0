From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Mon, 9 Nov 2015 17:29:58 -0500
Message-ID: <56411E66.2030104@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <CAHp75VfH9-OpQdX_aoraLEcHewdRPFoR5My8mN2jU30ittS7oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39577 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbKIWaB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2015 17:30:01 -0500
In-Reply-To: <CAHp75VfH9-OpQdX_aoraLEcHewdRPFoR5My8mN2jU30ittS7oA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, Andy Gross <agross@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 11/8/2015 3:35 PM, Andy Shevchenko wrote:
> On Sun, Nov 8, 2015 at 6:07 PM, Sinan Kaya <okaya@codeaurora.org> wro=
te:
>> The ACPI compiler uses the extended format when
>> used interrupt numbers are greater than 256.
>> The PCI link code currently only supports simple
>> interrupt format. The IRQ numbers are represented
>> using 32 bits when extended IRQ syntax. This patch
>> changes the interrupt number type to 32 bits and
>> places an upper limit of 1020 as possible interrupt
>> id. Additional checks have been placed to prevent
>> out of bounds writes.
>
> In commit messages and in comments I see this narrow lines, any reaso=
n
> to make them short, except increasing number of lines?
>

done

>>          if (acpi_irq_balance || !link->irq.active) {
>> -               /*
>> -                * Select the best IRQ.  This is done in reverse to =
promote
>> -                * the use of IRQs 9, 10, 11, and >15.
>> -                */
>> -               for (i =3D (link->irq.possible_count - 1); i >=3D 0;=
 i--) {
>> -                       if (acpi_irq_penalty[irq] >
>> -                           acpi_irq_penalty[link->irq.possible[i]])
>> -                               irq =3D link->irq.possible[i];
>> +
>> +               if (irq < ACPI_MAX_IRQS) {
>> +                       /*
>> +                        * Select the best IRQ.  This is done in rev=
erse to
>> +                        * promote the use of IRQs 9, 10, 11, and >1=
5.
>> +                        */
>> +                       for (i =3D (link->irq.possible_count - 1); i=
 >=3D 0;
>> +                               i--) {
>
> Why not
>
> if ((acpi_irq_balance || !link->irq.active) && irq < ACPI_MAX_IRQS) {
>   int i =3D link->irq.possible_count;
>
>   while (--i) {
>   =E2=80=A6
>   }
> }

done

>
>> +                               if ((link->irq.possible[i] < ACPI_MA=
X_IRQS) &&
>> +                                   (acpi_irq_penalty[irq] >
>> +                                   acpi_irq_penalty[link->irq.possi=
ble[i]]))
>> +                                       irq =3D link->irq.possible[i=
];
>> +                       }
>>                  }
>>          }
>>          if (acpi_irq_penalty[irq] >=3D PIRQ_PENALTY_ISA_ALWAYS) {
>

--=20
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, In=
c.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a=20
Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
