From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI support in common clock framework
Date: Wed, 13 Jun 2018 10:27:39 +0200
Message-ID: <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Srinath Mannam <srinath.mannam@broadcom.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 13, 2018 at 10:13 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> +Cc: Rafael, ACPI ML
>
> On Wed, Jun 13, 2018 at 7:14 AM, Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
>> Hi Michael, Stephen,
>>
>> We are adding ACPI support in our Linux based platform.
>> At present our clock hierarchy using common clock framework through DTS.
>> Now we required ACPI support in common clock framework to upgrade our platform.
>>
>> For example, clk_get API called in many drivers to get clock device is
>> tightly coupled with DT framework.
>>
>> Please let us know, if anybody in Open Source community have plans to
>> add ACPI support for common clock framework.

There are no plans for doing that AFAICS.

Moreover, it generally would not be consistent with ACPI power
management defined by the specification.

>> If not please suggest us alternative method to use common clock
>> framework in ACPI use case.

The problem with using the clock framework on systems with ACPI is
that, in general, the clock manipulation is expected to be carried out
by ACPI power management and therefore it is "owned" by AML.
Currently, there are no defined methods for synchronizing the AML's
use of clocks for power management with what the OS may do with them
directly.

In theory, that can be worked around to some extent by representing
clocks as power resources in ASL (even though the provider information
would be missing then) and manipulating those power resources directly
from the OS.  I'm not aware of anyone doing that successfully,
however.

For simple power management it should be sufficient to let drivers
rely on the ACPI PM domain which should happen automatically in the
majority of cases anyway.

Thanks,
Rafael
