From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: ACPI support in common clock framework
Date: Wed, 13 Jun 2018 11:13:28 +0300
Message-ID: <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

+Cc: Rafael, ACPI ML

On Wed, Jun 13, 2018 at 7:14 AM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> Hi Michael, Stephen,
>
> We are adding ACPI support in our Linux based platform.
> At present our clock hierarchy using common clock framework through DTS.
> Now we required ACPI support in common clock framework to upgrade our platform.
>
> For example, clk_get API called in many drivers to get clock device is
> tightly coupled with DT framework.
>
> Please let us know, if anybody in Open Source community have plans to
> add ACPI support for common clock framework.
> If not please suggest us alternative method to use common clock
> framework in ACPI use case.
>
> Thanks in advance.
>
> Regards,
> Srinath.



-- 
With Best Regards,
Andy Shevchenko
