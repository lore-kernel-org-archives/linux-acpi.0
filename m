From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [ACPI] [2.6 patch] drivers/acpi: remove unused exported functions
Date: Sat, 6 Nov 2004 22:26:46 +0100
Message-ID: <20041106212646.GO1295@stusta.de>
References: <20041105215021.GF1295@stusta.de> <20041106203934.GA27251@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261476AbUKFV10@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041106203934.GA27251@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 06, 2004 at 08:39:34PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 05, 2004 at 10:50:21PM +0100, Adrian Bunk wrote:
> > -acpi_status
> > -acpi_install_gpe_block (
> > -	acpi_handle                     gpe_device,
> > -	struct acpi_generic_address     *gpe_block_address,
> > -	u32                             register_count,
> > -	u32                             interrupt_level);
> > -
> > -acpi_status
> > -acpi_remove_gpe_block (
> > -	acpi_handle                     gpe_device);
> > -
> 
> I just wrote a driver that uses these two.  Probably best if you refer to
> http://developer.intel.com/technology/iapc/acpi/downloads/ACPICA-ProgRef.pdf
> before deleting "unused" functions as these are part of the published
> interfaces that the ACPICA provides.

If an in-kernel usage for some of the functions is coming soon simply 
ignore these parts of my patch.

But if there's EXPORT_SYMBOL'ed code since nearly since nearly three 
years in the kernel that has like drivers/acpi/hardware/hwtimer.c 
exactly zero users, the only effect of this code is a code bloat for all 
users of ACPI.

Prehaps #ifdef 0's are the best solution for published but unused 
interfaces?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
