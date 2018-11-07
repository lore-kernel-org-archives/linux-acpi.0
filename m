From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Date: Wed, 7 Nov 2018 14:35:19 +0200
Message-ID: <20181107123519.GH13048@kuha.fi.intel.com>
References: <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com>
 <20181106122734.GC13048@kuha.fi.intel.com>
 <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
 <20181106144037.GD13048@kuha.fi.intel.com>
 <20181106145537.GB10650@smile.fi.intel.com>
 <20181106150503.GE13048@kuha.fi.intel.com>
 <20181106155347.GC10650@smile.fi.intel.com>
 <CAL_JsqLdEciRtssX+x8TRmPX6QzZtNyMX9MrT9=J0DhhewFMZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLdEciRtssX+x8TRmPX6QzZtNyMX9MrT9=J0DhhewFMZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 06, 2018 at 12:13:30PM -0600, Rob Herring wrote:
> On Tue, Nov 6, 2018 at 9:53 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Nov 06, 2018 at 05:05:03PM +0200, Heikki Krogerus wrote:
> >
> > > Maybe it would be best to just read the "name" device property in
> > > fwnode_name() and not have of_fwnode_name at all.
> >
> > If it's a mandatory property or somehow its presence is guaranteed, it would work.
> 
> It is currently, but after removing the name ptr, my current plan is
> to remove the 'name' property too for FDT. On real OpenFirmware, it is
> a real property so it will remain for sure in some cases.

OK. I think we'll use the full_name after all.

thanks,

-- 
heikki
