From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for November 12 (acpi/processor.h)
Date: Thu, 12 Nov 2009 09:40:12 -0800
Message-ID: <20091112094012.2ef401ad.randy.dunlap@oracle.com>
References: <20091112195101.63263490.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20091112195101.63263490.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, lenb@kernel.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 12 Nov 2009 19:51:01 +1100 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20091111:
> 
> The cpufreq tree gained a conflict against the acpi tree.

when CONFIG_CPU_FREQ=n:

arch/x86/kernel/acpi/processor.o: In function `acpi_processor_get_bios_limit':
(.text+0x0): multiple definition of `acpi_processor_get_bios_limit'
arch/x86/kernel/acpi/cstate.o:(.text+0x0): first defined here


The function definition in include/apci/procssor.h needs to be "static inline"
at line 323.

---
~Randy
