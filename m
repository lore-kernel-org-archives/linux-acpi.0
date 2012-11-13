From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Replacement][PATCH 3/3]
Date: Tue, 13 Nov 2012 17:18:13 +0200
Message-ID: <20121113151813.GK31759@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <1440764.Vb4SkUrF9O@vostro.rjw.lan>
 <20121113141642.GJ31759@intel.com>
 <1956273.aTIDahOxd1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1956273.aTIDahOxd1@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, Bjorn Helgaas <bhelgaas@google.com>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 13, 2012 at 04:15:51PM +0100, Rafael J. Wysocki wrote:
> > Could we change this so that you can pass NULL list as well (provided that
> > the preproc is given)?
> > 
> > This is useful in case when we try to find the SPI/I2C device handle based
> > on the ACPI serial bus resource address. In that case we are not interested
> > in any other resources (and hence there is no need to allocate memory for
> > them etc.)
> 
> I'd prefer to have a separate helper function for that, if that's not a
> problem.  It should be clear when we ask for resources of a given device
> and when we only want to poke things like that.

It's not a problem, we can have a separate helper for that.
