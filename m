From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND] [PATCH 0/6] ACPI: ACPI table management enhancement
Date: Mon, 01 Dec 2008 21:38:24 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812012137060.339@localhost.localdomain>
References: <1226478538.15014.170.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_GnY/u0Zad6MDz6AXeWW9YQ)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37542 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbYLBCi0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 21:38:26 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KB8002WLA01Y482@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Dec 2008 20:38:26 -0600 (CST)
In-reply-to: <1226478538.15014.170.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_GnY/u0Zad6MDz6AXeWW9YQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

I sort of worried that we'd not print the table physical address
like we have in acpidump output.

but i guess we print out the root pointer and active [X|R]SDT
in the top of DMESG, so I guess we do have that info available
after all and don't really need to dump the XSDT here...

-- 
-Len Brown
Intel Open Source Technology Center

On Wed, 12 Nov 2008, Zhang Rui wrote:

> ﻿hi all,
> 
> this is the patch set I made recently for ACPI table management
> enhancement.
> 
> Patch 01 creates the sysfs I/F for ACPI dynamic tables.
> 
> Patch 02 introduces a new mechanism for ACPI inactive table management.
> 
> Patch 03 initializes the inactive tables at boot time and builds sysfs
> I/F for these tables.
> 
> Patch 04 introduces ACPI_INACTIVE_TABLE_MANAGEMENT to make the inactive
> table management configurable.
> 
> here is the ACPI table sysfs I/F on my laptop after applying these
> patches.
> #tree /sys/firmware/acpi/tables/
> ﻿/sys/firmware/acpi/tables/
> |-- APIC
> |-- ASF!
> |-- DMAR
> |-- DSDT
> |-- FACP
> |-- FACS
> |-- HPET
> |-- MCFG
> |-- SLIC
> |-- SSDT1
> |-- SSDT2
> |-- SSDT3
> |-- SSDT4
> |-- dynamic
> |   |-- SSDT5
> |   |-- SSDT6
> |   |-- SSDT7
> |   `-- SSDT8
> `-- inactive
>     |-- APIC
>     |-- ASF!
>     |-- DMAR
>     |-- DSDT
>     |-- FACP
>     |-- FACS
>     |-- HPET
>     |-- MCFG
>     |-- RSDT
>     |-- SLIC
>     |-- SSDT1
>     |-- SSDT2
>     |-- SSDT3
>     `-- SSDT4
> 
> 2 directories, 31 files
> 
> Patch 05 and Patch 06 fix a suspend/hibernation bug for me.
> I have a test box which suspends well, but always reboots instead of
> resuming when pressing the power button.
> I found that there are two FACS tables on this platform,
> XSDT-->FADT1-->Xfacs------>FACS1
> 	|----->facs-----|
> 			|->FACS2
> RSDT-->FADT2-->facs-----|
> Linux uses XSDT on this platform and sets the waking vector in FACS1
> when suspending. But it seems that the BIOS only cares for the waking
> vector in FACS2, thus it reboots when resuming because the waking vector
> is not set at all.
> 
> FADT1.facs is installed to the acpi_gbl_root_table_list in Patch 05.
> And the waking vector of FADT1.facs is set during suspend in Patch 06.
> 
> any comments are welcome. :)
> 
> thanks,
> rui
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--Boundary_(ID_GnY/u0Zad6MDz6AXeWW9YQ)--
