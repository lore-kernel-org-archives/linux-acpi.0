From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: 2.6.0-test7 build failure: !CONFIG_PCI
Date: 10 Oct 2003 23:43:05 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1065843784.4112.49.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE001126CB1@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE001126CB1-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Linux-Kernel (E-mail)" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Does anybody build X86 without CONFIG_PCI?

Build fails if CONFIG_BLK_DEV_CMD640 is set:

drivers/built-in.o(.init.text+0x59df): In function `ide_setup':
: undefined reference to `cmd640_vlb'
drivers/built-in.o(.init.text+0x5aef): In function `probe_for_hwifs':
: undefined reference to `ide_probe_for_cmd640x'
make: *** [.tmp_vmlinux1] Error 1

The problem is that these variables are defined in
drivers/ide/pci/cmd640.c, which is protected by CONFIG_PCI; but they're
used when CONFIG_BLK_DEV_CMD640, which doesn't require CONFIG_PCI.

---
More interesting (to me) is that it also fails if CONFIG_ACPI is set:

drivers/built-in.o(.init.text+0x825): In function `acpi_bus_init':
: undefined reference to `eisa_set_level_irq'

drivers/acpi/bus.c:

#ifdef CONFIG_X86
        /* Ensure the SCI is set to level-triggered, active-low */
        if (acpi_ioapic)
                mp_config_ioapic_for_sci(acpi_fadt.sci_int);
        else
                eisa_set_level_irq(acpi_fadt.sci_int);
#endif

Should we not be calling eisa_set_level_irq()?

thanks,
-Len




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
