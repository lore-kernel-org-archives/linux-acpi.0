From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Date: Fri, 2 Nov 2018 17:15:48 +0200
Message-ID: <20181102151548.GA10650@smile.fi.intel.com>
References: <20181102110653.118257-1-arnd@arndb.de>
 <3c6ddd48-b419-52db-38d3-e0ebf9c46dfc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3c6ddd48-b419-52db-38d3-e0ebf9c46dfc@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 02, 2018 at 12:09:34PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 02-11-18 12:06, Arnd Bergmann wrote:
> > We still get a link failure with IOSF_MBI=m when the xpower driver
> > is built-in:
> > 
> > drivers/acpi/pmic/intel_pmic_xpower.o: In function `intel_xpower_pmic_update_power':
> > intel_pmic_xpower.c:(.text+0x4f2): undefined reference to `iosf_mbi_block_punit_i2c_access'
> > intel_pmic_xpower.c:(.text+0x5e2): undefined reference to `iosf_mbi_unblock_punit_i2c_access'
> > 
> > This makes the dependency stronger, so we can only build when IOSF_MBI
> > is built-in.
> > 
> > Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Hmm, it is probably better to make IOSF_MBI a bool, it is selected by:
> X86_INTEL_QUARK and X86_INTEL_LPSS which are both bools themselves.
> 
> Arguably it should also be hidden and only enabled through these selects.
> Does someone from Intel have an opinion on making it hidden?

We have number of cases where tristate modules depend on or select it.
So, I have not seen a good argument to make it boolean.

-- 
With Best Regards,
Andy Shevchenko
