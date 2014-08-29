From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Add GPIO-signaled event emulator.
Date: Sat, 30 Aug 2014 00:37:11 +0200
Message-ID: <4311575.xGvmD61lSo@vostro.rjw.lan>
References: <1408546700-19309-1-git-send-email-tomasz.nowicki@linaro.org> <1828087.V5efjsXTdI@vostro.rjw.lan> <53FF1054.508@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53FF1054.508@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linus.walleij@linaro.org, gnurou@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, August 28, 2014 01:19:48 PM Tomasz Nowicki wrote:
> On 26.08.2014 00:39, Rafael J. Wysocki wrote:
> > On Thursday, August 21, 2014 04:39:46 PM Tomasz Nowicki wrote:
> >> Hi Mika,
> >>
> >> On 21.08.2014 12:45, Mika Westerberg wrote:
> >>> On Wed, Aug 20, 2014 at 04:58:20PM +0200, Tomasz Nowicki wrote:
> >
> > [cut]
> >
> >>>> +
> >>>> +static int gpio_evt_trigger(void *data, u64 val)
> >>>> +{
> >>>> +	struct gpio_pin_data *pin_data = (struct gpio_pin_data *)data;
> >>>> +	int pin = pin_data->pin;
> >>>> +
> >>>> +	if (ACPI_FAILURE(acpi_execute_simple_method(pin_data->handle, NULL,
> >>>> +						    pin <= 255 ? 0 : pin)))
> >>>> +		pr_err(PREFIX "evaluating event method failed\n");
> >>>
> >>> acpi_execute_simple_method() passes one argument to the method. You
> >>> can't use it with _Lxx or _Exx which don't expect any arguments.
> >>> Otherwise you get this:
> >>>
> >>> [  122.258191] ACPI: \_SB_.GPO2._E12: Excess arguments - Caller passed 1, method requires 0 (20140724/nsarguments-263)
> >> Right, I will fix it.
> >
> > OK, so here's my concern.
> >
> > If AML does any kind of tracking of state in _Exx/_Lxx, you'll likely totally
> > confuse it by calling those things at random.
> >
> > I'm not sure I'm seeing a compelling reason to put this thing into the tree
> > for this reason.
> 
> Yes you are right, but this emulator is only for debugging/development 
> purposes and goes with clear statement "DANGER to use on production 
> kernel", like APEI error injection feature.
> 
> IMO, this emulator would help with:
> 1. testing and developing AML methods
> 2. working on ACPI subsystems that need GPIO-signaled events without 
> GPIO h/w

OK

And why does that belong to the kernel source tree and not to an ACPI/UEFI
test suite?

Rafael
