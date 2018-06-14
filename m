From: okaya@codeaurora.org
Subject: Re: ACPI support in common clock framework
Date: Thu, 14 Jun 2018 07:07:47 -0400
Message-ID: <977a6d1c83b4084b949162258bb1007a@codeaurora.org>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
 <CABe79T5i8zUcBJnFmM-pAvzXf2CZXesh4NqxSGFj8f0Z-c8m1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABe79T5i8zUcBJnFmM-pAvzXf2CZXesh4NqxSGFj8f0Z-c8m1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 2018-06-14 06:58, Srinath Mannam wrote:
> Thank you Andy,
> 
> Regards,
> Srinath.
> 
> On Wed, Jun 13, 2018 at 1:43 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> +Cc: Rafael, ACPI ML
>> 
>> On Wed, Jun 13, 2018 at 7:14 AM, Srinath Mannam
>> <srinath.mannam@broadcom.com> wrote:
>>> Hi Michael, Stephen,
>>> 
>>> We are adding ACPI support in our Linux based platform.
>>> At present our clock hierarchy using common clock framework through 
>>> DTS.
>>> Now we required ACPI support in common clock framework to upgrade our 
>>> platform.
>>> 
>>> For example, clk_get API called in many drivers to get clock device 
>>> is
>>> tightly coupled with DT framework.
>>> 
>>> Please let us know, if anybody in Open Source community have plans to
>>> add ACPI support for common clock framework.
>>> If not please suggest us alternative method to use common clock
>>> framework in ACPI use case.

Are you hooking up clk apis to PS0/PS3 calls?

Clk api didn't play nice with acpi until now.

>>> 
>>> Thanks in advance.
>>> 
>>> Regards,
>>> Srinath.
>> 
>> 
>> 
>> --
>> With Best Regards,
>> Andy Shevchenko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
