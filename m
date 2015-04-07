From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] dynamic table unload fixes
Date: Tue, 07 Apr 2015 13:58:31 +0200
Message-ID: <238075831.fMDaijivDm@vostro.rjw.lan>
References: <1428077269-12764-1-git-send-email-bob.j.paauwe@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55358 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752518AbbDGLeK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2015 07:34:10 -0400
In-Reply-To: <1428077269-12764-1-git-send-email-bob.j.paauwe@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Paauwe <bob.j.paauwe@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

On Friday, April 03, 2015 09:07:47 AM Bob Paauwe wrote:
> While trying to make use of dynamic tables as a way to provide driver
> initialization properties, I've encountered a couple of issues with the
> way dynamic tables are being handled.
> 
> The first patch appears to be a bug. There is a mutex release without
> a corresponding aquire. This extra release causes a mutex error message
> when a table is re-loaded after being unloaded.
> 
> The second patch actually unloads a table when table unload is called. 
> When a table is being dynamically loaded by a driver module and that
> driver module is unloaded, the memory for the table would typically be
> freed resulting in a table that is marked as unloaded but still pointing
> to that freed memory.  If the driver module is then re-loaded, the
> ACPI table reload function will attempt to access that freed memory when
> it does a table compare and results in a oops.
> 
> These patches solve the problems I've encountered but may not be the 
> proper way to solve.
> 
> Bob Paauwe (2):
>   Remove extra release mutex call.
>   Acutally unload a table.
> 
>  drivers/acpi/acpica/tbinstal.c | 1 -
>  drivers/acpi/acpica/tbxfload.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

This is ACPICA material.  Please *at* *least* CC it to the ACPICA maintainers
as per MAINTAINERS, but it really should be sent to the ACPICA list (and you
can CC linux-acpi if that is useful too).


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
