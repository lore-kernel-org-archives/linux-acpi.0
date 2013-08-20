From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] acpi_i2c: set MODULE_LICENSE, MODULE_AUTHOR, and
 MODULE_DESCRIPTION
Date: Tue, 20 Aug 2013 11:14:42 +0300
Message-ID: <20130820081442.GU4898@intel.com>
References: <1376702795-25912-1-git-send-email-jerry.snitselaar@oracle.com>
 <2870377.GVGv4QBgQK@vostro.rjw.lan>
 <20130819233528.GA4587@cantor.us.oracle.com>
 <1838503.PYpZe7GJ51@vostro.rjw.lan>
 <20130820033403.GD4587@cantor.us.oracle.com>
 <20130820072820.GT4898@intel.com>
 <20130820080008.GE4587@cantor.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130820080008.GE4587@cantor.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerry Snitselaar <jerry.snitselaar@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 20, 2013 at 01:00:08AM -0700, Jerry Snitselaar wrote:
> On Tue Aug 20 13, Mika Westerberg wrote:
> > On Mon, Aug 19, 2013 at 08:34:03PM -0700, Jerry Snitselaar wrote:
> > > On Tue Aug 20 13, Rafael J. Wysocki wrote:
> > > > On Monday, August 19, 2013 04:35:29 PM Jerry Snitselaar wrote:
> > > > > On Tue Aug 20 13, Rafael J. Wysocki wrote:
> > > > > > On Monday, August 19, 2013 09:16:14 AM Mika Westerberg wrote:
> > > > > > > On Fri, Aug 16, 2013 at 06:26:35PM -0700, Jerry Snitselaar wrote:
> > > > > > > > Without MODULE_LICENSE set, I get the following with modprobe:
> > > > > > > > 
> > > > > > > > acpi_i2c: module license 'unspecified' taints kernel.
> > > > > > > > acpi_i2c: Unknown symbol i2c_new_device (err 0)
> > > > > > > > acpi_i2c: Unknown symbol acpi_dev_get_resources (err 0)
> > > > > > > > acpi_i2c: Unknown symbol acpi_dev_resource_interrupt (err 0)
> > > > > > > > acpi_i2c: Unknown symbol acpi_dev_free_resource_list (err 0)
> > > > > > > > 
> > > > > > > > Signed-off-by: Jerry Snitselaar <jerry.snitselaar@oracle.com>
> > > > > > > 
> > > > > > > Looks good to me.
> > > > > > > 
> > > > > > > Acked-by: Mika Westerbeg <mika.westerberg@linux.intel.com>
> > > > > > 
> > > > > > Well, OK, but do we need to be able to build that as a module?
> > > > > > 
> > > > > > Maybe it should just be yes or no?
> > > > > > 
> > > > > > Rafael
> > > > > > 
> > > > > 
> > > > > Perhaps have depends on I2C=y and be a bool instead of tristate?
> > > > 
> > > > Yes, that's the idea.
> > > > 
> > > Does this look okay Mika?
> > > 
> > > [PATCH] acpi_i2c: do not build as loadable module
> > > 
> > > Change from tristate to bool, and depend on I2C=y
> > 
> > I'm not sure about this. Does the below mean that we can't build the ACPI
> > I2C enumeration at all if I2C core is compiled as module?
> 
> Yes, that was what Rafael was suggesting. If the ability to compile as
> a module if I2C is a module is needed, then we need the 1st patch.

In that case I would prefer the first patch. Otherwise we lose the ability
to enumerate I2C devices from ACPI namespace on some distros (at least
Debian builds I2C core as a module).

Rafael?
