From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.25-rc2-mm1 (x64 thermal build failure)
Date: Sat, 16 Feb 2008 21:44:10 -0800
Message-ID: <20080216214410.b9699910.akpm@linux-foundation.org>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org>
	<20080216211603.bb4f3582.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40530 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750779AbYBQFog (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Feb 2008 00:44:36 -0500
In-Reply-To: <20080216211603.bb4f3582.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Sat, 16 Feb 2008 21:16:03 -0800 Randy Dunlap <randy.dunlap@oracle.com> wrote:

> On Sat, 16 Feb 2008 00:25:22 -0800 Andrew Morton wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.25-rc2/2.6.25-rc2-mm1/
> 
> ACPI is enabled, but DMI=n.
> 
> linux-2.6.25-rc2-mm1/drivers/acpi/thermal.c: In function 'acpi_thermal_init':
> linux-2.6.25-rc2-mm1/drivers/acpi/thermal.c:1792: error: 'thermal_dmi_table' undeclared (first use in this function)
> linux-2.6.25-rc2-mm1/drivers/acpi/thermal.c:1792: error: (Each undeclared identifier is reported only once
> linux-2.6.25-rc2-mm1/drivers/acpi/thermal.c:1792: error: for each function it appears in.)
> make[3]: *** [drivers/acpi/thermal.o] Error 1
> 

Bustage in x86-configurable-dmi-scanning-code.patch.  Previously, DMI=y was
just hardwired.  Now, it becomes selectable and stuff breaks.

I guess the DMI=n version of dmi_check_system() could become a macro so we
don't emit a reference to its argument, but that might generate
unused-variable warnings elsewhere.

