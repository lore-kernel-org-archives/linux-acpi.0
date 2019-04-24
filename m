From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Wed, 24 Apr 2019 18:33:17 +0300
Message-ID: <20190424153317.GN2654@lahna.fi.intel.com>
References: <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190424104613.GD2654@lahna.fi.intel.com>
 <761ed823-58f4-d166-c415-6b100b1fe615@siemens.com>
 <20190424131357.GJ2654@lahna.fi.intel.com>
 <0bb42b3e-58cc-a11c-b8ad-fec67da477b4@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0bb42b3e-58cc-a11c-b8ad-fec67da477b4@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 24, 2019 at 04:24:16PM +0200, Jan Kiszka wrote:
> > I'm trying to say that for the sysfs access (well or char dev) you
> > should not need the sch_sci_handler() thing that is in your current
> > patch.
> 
> Then I'm still missing the black magic where - in my case - CGTS or RGTS are
> read, evaluated and written back.
> 
> And we would still need the gpio-sch driver to handle GGPE, GTNE, GTPE when
> edge events are requested? Is the a reference for /such/ a case? The newer
> Intels must be different then.

I realized the patch does not get an IRQ resource for the device so the
sch_sci_handler() is used to circumvent that. Yeah, if you don't have
IRQ resource available from the device ACPI description then I guess
hooking into ACPI SCI might be sensible thing to do after all...
