From: Lin Ming <lin@minggr.cn>
Subject: Re: Locking out AML code
Date: Tue, 7 Jul 2009 22:29:15 +0800
Message-ID: <d3f22a0907070729j2ded2702s6b001cbf51df0566@mail.gmail.com>
References: <4A5356C2.3090608@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:7067 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbZGGO3V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2009 10:29:21 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1782713wfd.4
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jul 2009 07:29:18 -0700 (PDT)
In-Reply-To: <4A5356C2.3090608@marcansoft.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hector Martin <hector@marcansoft.com>
Cc: linux-acpi@vger.kernel.org

On Tue, Jul 7, 2009 at 10:08 PM, Hector Martin<hector@marcansoft.com> wrote:
> I'm writing a driver to access some EC-related functionality on some
> Acer laptops. This uses a separate IO port interface and cannot be done
> using the standard ec_read / ec_write ACPI functions. The DSDT also
> accesses these IO ports for a few things (most notably display
> brightness and some WMI methods). Is there a lock I can hold (from
> outside the ACPI subsystem) that will lock out AML method execution
> while I poke the hardware?

Try acpi_os_acquire_lock(acpi_gbl_hardware_lock).

But acpi_gbl_hardware_lock is defined in the ACPICA internal header
"drivers/acpi/acpica/acglobal.h",
you need to move it to public header, for example, include/acpi/acpixf.h

Lin Ming

>
> FWIW, the Windows drivers from Acer also access those IO ports directly
> (from userspace, no less, with a dumb kernel driver to provide port I/O
> to userspace and in the process introduce a huge security hole of
> course). There is no way of talking to this hardware via DSDT methods.
>
> --
> Hector Martin (hector@marcansoft.com)
> Public Key: http://www.marcansoft.com/marcan.asc
