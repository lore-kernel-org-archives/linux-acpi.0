From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Date: Tue, 26 Mar 2019 15:55:57 +0200
Message-ID: <20190326135557.GD9224@smile.fi.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190322172114.GY9224@smile.fi.intel.com>
 <20190324181745.vgckevapfwi7mul7@mara.localdomain>
 <20190326131353.GY9224@smile.fi.intel.com>
 <20190326133947.pbniwkvszlahw3dr@paasikivi.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326133947.pbniwkvszlahw3dr@paasikivi.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 26, 2019 at 03:39:47PM +0200, Sakari Ailus wrote:
> On Tue, Mar 26, 2019 at 03:13:53PM +0200, Andy Shevchenko wrote:
> > On Sun, Mar 24, 2019 at 08:17:46PM +0200, Sakari Ailus wrote:

> > The patch series by Petr I mentioned takes care about OF case. But it doesn't
> > have covered yours by obvious reasons.
> 
> Do you happen to have a pointer to it?

Petr, can you share what is the state of affairs with that series?

> The behaviour on others is different indeed, you're generally printing a
> single item at a time. The question rather is, whether we want to be
> compatible with %pOF going forward or not. I'd prefer that, so using the
> fwnode API would be easier.

I would prefer to mimic %pOF and actually to deprecate it in favour of %pfw.
But it's just mine opinion. I'm skeptical about getting support on it.

-- 
With Best Regards,
Andy Shevchenko
