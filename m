From: Adrian Bunk <bunk@fs.tum.de>
Subject: 2.6.6-rc3-mm1: modular ACPI button broken
Date: Sat, 1 May 2004 13:44:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040501114420.GF2541@fs.tum.de>
References: <20040430014658.112a6181.akpm@osdl.org> <87ad0sshku.fsf@basilikum.skogtun.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S261638AbUEALo2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87ad0sshku.fsf@basilikum.skogtun.org>
To: Harald Arnesen <harald@skogtun.org>, len.brown@intel.com, luming.yu@intel.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Sat, May 01, 2004 at 10:00:01AM +0200, Harald Arnesen wrote:
> I don't see this in plain 2.6.6-rc3 or 2.6.6-rc2-mm2:
> 
> 
> $ sudo make modules_install
> INSTALL...
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map
> 2.6.6-rc3-mm1; fi
> WARNING: /lib/modules/2.6.6-rc3-mm1/kernel/drivers/acpi/button.ko needs
> unknown symbol acpi_fixed_sleep_button
> WARNING: /lib/modules/2.6.6-rc3-mm1/kernel/drivers/acpi/button.ko needs
> unknown symbol acpi_fixed_pwr_button
> $
>...

Thanks for this report.

This seems to be introduced by the button driver unload unload patch 
(Bugzilla #2281) included in the ACPI BK patch.

It seems two EXPORT_SYMBOL's are missing in scan.c?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
