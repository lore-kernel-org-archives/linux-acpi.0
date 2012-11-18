From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI: Simplify "glueing" to physical nodes (was: Re: [PATCH v2 3/3 UPDATED] i2c / ACPI: add ACPI enumeration support)
Date: Sun, 18 Nov 2012 22:10:33 +0100
Message-ID: <1758879.PKgPhTGcB7@vostro.rjw.lan>
References: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com> <3790210.BPELRzTIaN@vostro.rjw.lan> <20121118155539.GE17774@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121118155539.GE17774@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jean Delvare <khali@linux-fr.org>, ben-linux@fluff.org, w.sang@pengutronix.de, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday, November 18, 2012 05:55:39 PM Mika Westerberg wrote:
> On Sat, Nov 17, 2012 at 12:24:45PM +0100, Rafael J. Wysocki wrote:
> > Well, maybe there is one.  Perhaps we can make acpi_platform_notify() 
> > call acpi_bind_one() upfront and only if that fails, do the whole
> > type->find_device() dance?  Of course, acpi_bind_one() would need to
> > be modified slightly too, like in the patch below.
> > 
> > If we did that, acpi_i2c_add_device() would only need to assign acpi_handle
> > as appropriate before calling i2c_new_device() (and analogously for SPI).
> > 
> > What do you think? 
> 
> This is certainly better than the thing we use currently. It makes adding
> I2C and SPI support much shorter and simpler. If others don't object I
> would suggest that we switch to use this method.

OK, thanks.

The first of the following two patches is a slightly modified version of the
one that you commented.  Patch [2/2] implements the idea for platform devices
and since it modifies struct platform_device_info, I'm adding a CC to Greg.

The patches are on top of current linux-pm.git/linux-next.

It looks like we may be able to use this approach for PCI too, in which case
the whole .find_device() stuff won't be necessary any more.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
