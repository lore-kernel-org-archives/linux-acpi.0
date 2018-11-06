From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Date: Tue, 6 Nov 2018 12:13:30 -0600
Message-ID: <CAL_JsqLdEciRtssX+x8TRmPX6QzZtNyMX9MrT9=J0DhhewFMZg@mail.gmail.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com> <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com> <20181106122734.GC13048@kuha.fi.intel.com>
 <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
 <20181106144037.GD13048@kuha.fi.intel.com> <20181106145537.GB10650@smile.fi.intel.com>
 <20181106150503.GE13048@kuha.fi.intel.com> <20181106155347.GC10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106155347.GC10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 6, 2018 at 9:53 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 06, 2018 at 05:05:03PM +0200, Heikki Krogerus wrote:
>
> > Maybe it would be best to just read the "name" device property in
> > fwnode_name() and not have of_fwnode_name at all.
>
> If it's a mandatory property or somehow its presence is guaranteed, it would work.

It is currently, but after removing the name ptr, my current plan is
to remove the 'name' property too for FDT. On real OpenFirmware, it is
a real property so it will remain for sure in some cases.

Rob
