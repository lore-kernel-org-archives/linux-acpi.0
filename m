From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for October 25 (acpi/apei-related)
Date: Mon, 25 Oct 2010 16:51:45 -0700
Message-ID: <20101025165145.1b48cd69.randy.dunlap@oracle.com>
References: <20101025145834.9b68e026.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20101025145834.9b68e026.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-acpi@vger.kernel.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 25 Oct 2010 14:58:34 +1100 Stephen Rothwell wrote:

> Hi all,

drivers/built-in.o: In function `herr_record_init':
(.text+0x85149): undefined reference to `trace_clock_local'
drivers/built-in.o: In function `herr_record_alloc':
(.text+0x851ab): undefined reference to `trace_clock_local'
drivers/built-in.o: In function `herr_record_alloc':
(.text+0x8521c): undefined reference to `trace_clock_local'


config ACPI_APEI
	bool "ACPI Platform Error Interface (APEI)"
	depends on X86
	select HERR_DEV_CORE

but kernel/trace/trace_clock is not built unless one of these symbols
is enabled:

obj-$(CONFIG_FUNCTION_TRACER) += trace/
obj-$(CONFIG_TRACING) += trace/
obj-$(CONFIG_X86_DS) += trace/
obj-$(CONFIG_RING_BUFFER) += trace/

and in this case, none of these is enabled.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
