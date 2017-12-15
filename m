From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V2] ACPI / LPSS: Add device link for CHT SD card
 dependency on I2C
Date: Fri, 15 Dec 2017 12:03:37 +0200
Message-ID: <1513332217.7000.81.camel@linux.intel.com>
References: <1512637396-17000-1-git-send-email-adrian.hunter@intel.com>
         <1513261011.7000.75.camel@linux.intel.com>
         <CAJZ5v0hLBODV4Tfh-TMa6Psh16Bbs_d9x51xjrweGGHAPpqqqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hLBODV4Tfh-TMa6Psh16Bbs_d9x51xjrweGGHAPpqqqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2017-12-15 at 01:58 +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 14, 2017 at 3:16 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, 2017-12-07 at 11:03 +0200, Adrian Hunter wrote:
> > > 

> > > 
> > > +static const struct x86_cpu_id cht_cpu[] = {
> > > +     ICPU(INTEL_FAM6_ATOM_AIRMONT),  /* Braswell, Cherry
> > > Trail */
> > > +     {}
> > > +};
> > 
> > I would rather to modify ICPU() macro to accept driver data where we
> > just pass an unsigned long value to be assigned as lpss_quirks and
> > introduce another quirk.
> 
> Not really.
> 
> There are many instances of ICPU() already in the tree and updating
> all of them is just not worth it.

These macros all over the code are local.
I'm talking about one which is defined inside acpi_lpss.c.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
