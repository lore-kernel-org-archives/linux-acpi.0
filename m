From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: ACPI support in common clock framework
Date: Fri, 15 Jun 2018 10:43:11 -0700
Message-ID: <152908459103.16708.4012421602830600322@swboyd.mtv.corp.google.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
 <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Srinath Mannam <srinath.mannam@broadcom.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Quoting Rafael J. Wysocki (2018-06-13 01:27:39)
> On Wed, Jun 13, 2018 at 10:13 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > +Cc: Rafael, ACPI ML
> >
> > On Wed, Jun 13, 2018 at 7:14 AM, Srinath Mannam
> > <srinath.mannam@broadcom.com> wrote:
> >> Hi Michael, Stephen,
> >>
> >> We are adding ACPI support in our Linux based platform.
> >> At present our clock hierarchy using common clock framework through DT=
S.
> >> Now we required ACPI support in common clock framework to upgrade our =
platform.
> >>
> >> For example, clk_get API called in many drivers to get clock device is
> >> tightly coupled with DT framework.
> >>
> >> Please let us know, if anybody in Open Source community have plans to
> >> add ACPI support for common clock framework.
> =

> There are no plans for doing that AFAICS.
> =

> Moreover, it generally would not be consistent with ACPI power
> management defined by the specification.

This matches my understanding.

> =

> >> If not please suggest us alternative method to use common clock
> >> framework in ACPI use case.
> =

> The problem with using the clock framework on systems with ACPI is
> that, in general, the clock manipulation is expected to be carried out
> by ACPI power management and therefore it is "owned" by AML.
> Currently, there are no defined methods for synchronizing the AML's
> use of clocks for power management with what the OS may do with them
> directly.
> =

> In theory, that can be worked around to some extent by representing
> clocks as power resources in ASL (even though the provider information
> would be missing then) and manipulating those power resources directly
> from the OS.  I'm not aware of anyone doing that successfully,
> however.
> =

> For simple power management it should be sufficient to let drivers
> rely on the ACPI PM domain which should happen automatically in the
> majority of cases anyway.
> =


Is this for clk_enable/disable? What about clk_set_rate() or
clk_set_phase()? Is ACPI's AML taking care of that?
