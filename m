From: Philipp Matthias Hahn <pmhahn-u4khhh1J0LzF41mA0N3lWw@public.gmane.org>
Subject: Problem Suspending with 2.5.44
Date: Mon, 21 Oct 2002 10:05:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021021080511.GB13629@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

1. I reported our desktop FSCs generating millions of interrupts with
ACPI, but since Linus's computer was fixed, our's is fixed as well.
Thank you.

2. My notebook (ASUS L8400) still dosn't work 100% with linux-2.5.44.
Buttons, processor, thermal zone, fans, ac, battery are detected and
seem to work. During boot I get the following message:
  SBF: ACPI BOOT descriptor is wrong length (39)
  SBF: Simple Boot Flag extension found and enabled.
  SBF: Setting boot flags 0x1
Is this something to worry about and/or can I fix it?

3. With acpi=off I get the following printed:
  PCI: IRQ 0 for device 00:06.0 doesn't match PIRQ mask - try pci=usepirqmask
  PCI: IRQ 0 for device 00:07.2 doesn't match PIRQ mask - try pci=usepirqmask
  PCI: IRQ 0 for device 00:08.0 doesn't match PIRQ mask - try pci=usepirqmask
  PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
  PCI: IRQ 0 for device 00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask

4. I tried "sleep 1;echo 1 > sleep" and got the following:

topping tasks: ====pdflush: bogus wakeup!
=pdflush: bogus wakeup!
===================
stopping tasks failed (1 tasks remaining)
Suspending devices
Suspending devices
Suspending devices
Devices Resumed
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
Devices Resumed
    ACPI-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
    ACPI-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
    ACPI-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
    ACPI-1155: *** Error: Method execution failed, AE_AML_NOT_OWNER
Restarting tasks...<6> Strange, eth0 not stopped
 Strange, kacpidpc not stopped
 done

Filesystems are ext2/ext3, eth0 is a 8139too, AT (non-USB) keyboard.
After that, I coundn't enter characters any more, but switching to X11
using Alt-F7 did work. Switching back to console I'm still not able to
enter commands. The DSDT is available from
http://pint.pmhahn.de/pmhahn/misc/dsdt-asus.dsl

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn-u4khhh1J0LzF41mA0N3lWw@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
