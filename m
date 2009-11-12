From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for November 12
 (acpi_processor_get_bios_limit)
Date: Thu, 12 Nov 2009 10:09:56 -0800
Message-ID: <20091112100956.fc72080e.randy.dunlap@oracle.com>
References: <20091112195101.63263490.sfr@canb.auug.org.au>
	<20091112094012.2ef401ad.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:45291 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbZKLSLN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2009 13:11:13 -0500
In-Reply-To: <20091112094012.2ef401ad.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thu, 12 Nov 2009 09:40:12 -0800 Randy Dunlap wrote:

> On Thu, 12 Nov 2009 19:51:01 +1100 Stephen Rothwell wrote:
> 
> > Hi all,
> > 
> > Changes since 20091111:
> > 
> > The cpufreq tree gained a conflict against the acpi tree.
> 
> when CONFIG_CPU_FREQ=n:
> 
> arch/x86/kernel/acpi/processor.o: In function `acpi_processor_get_bios_limit':
> (.text+0x0): multiple definition of `acpi_processor_get_bios_limit'
> arch/x86/kernel/acpi/cstate.o:(.text+0x0): first defined here
> 
> 
> The function definition in include/apci/procssor.h needs to be "static inline"
> at line 323.

---
however, even with that fixed, when

CONFIG_CPU_FREQ=y
CONFIG_ACPI=n
CONFIG_SFI=y
CONFIG_APM=y

there is this build error:

arch/x86/kernel/cpu/cpufreq/powernow-k7.c:720: error: 'acpi_processor_get_bios_limit' undeclared here (not in a function)

---
~Randy
