From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Mon, 14 Apr 2008 21:18:09 +0200
Message-ID: <1208200689.1784.126.camel@queen.suse.de>
References: <20080305030147.GA25310@earth.gruber.myown>
	 <1207784442.32532.0.camel@earth.gruber.myown>
	 <1208103760.19605.5.camel@earth.gruber.myown>
	 <1208169984.1784.37.camel@queen.suse.de>
	 <1208193500.11305.17.camel@earth.gruber.myown>
	 <1208195761.1784.95.camel@queen.suse.de>
	 <1208197360.11305.33.camel@earth.gruber.myown>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59182 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757258AbYDNTSL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 15:18:11 -0400
In-Reply-To: <1208197360.11305.33.camel@earth.gruber.myown>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: linux-acpi@vger.kernel.org

On Mon, 2008-04-14 at 20:22 +0200, nokos@gmx.net wrote:
> > > clause which seems to stop SBLL from working and GBLS which is a variant of GBLL with similar problem.
> > > The whole point of the parameter use_alt_lcd_levels was to have an easy way to switch between
> > > SBLL/GBLL (not working on S6410) and SBL2/GBLS (working on S6410)
> > 
> > Hmm, you mean because NGTF has another value on your machine?
> > Trying to get this solved automatically would be great...
> 
> I have not yet tried to readout the NGTF with a platform device. Hmm,
> how do access fields like NGTF (All I have done so far was calling
> functions like GBLL() and examining the return value). 
> 
> According to the DSDT should FUNC(0x1004,1,4,0) switch off NGTF, but
> then SBLL is still not working. 
> 
> Where can I find some documentation of the DSL/ASL language? Are there
> docs about the linux-acpi interface?

All the docs you need and AFAIK the only document is the ACPI spec
itself:
www.acpi.info
Hmm, could it be that this site is not accessible (already for some
time)?

You could disassemble, modify and override your DSDT via initrd or
compiling into the kernel.

Before add:
Store (NGTF, Debug)
statements into the DSDT, compile the kernel with ACPI_DEBUG=y and
increase the debug level
acpi.debug_level=0x1F
debug object should be added:
cat /sys/module/acpi/parameters/debug_level
to modify the value at runtime echo the mask in there directly:
echo 0x1F> /sys/module/acpi/parameters/debug_level
for example will increase the debug level up to INFO.

There is also a convenient ASL function tracing debug facility in recent
kernels, but I haven't used it yet.
AFAIK you echo the ASL function in there..., the git commit for that has
some more info:


commit 4169c45f179e285feac6bcf25f4bd0db6b109bab
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Wed Nov 14 19:38:40 2007 -0500

    ACPI: add control method tracing support
    
    Add debug tracing support during certain AML method execution.
    
    Four more module parameters are created under /sys/module/acpi/parameters/:
    trace_method_name:  the AML method name that user wants to trace
    
    trace_debug_layer:  the temporary debug_layer used when tracing the method.
                        Using 0xffffffff by default if it is 0.
    
    trace_debug_level:  the temporary debug_level used when tracing the method.
                        Using 0x00ffffff by default if it is 0.
    
    trace_state:                The status of the tracing feature.
                        "enabled" means this feature is enabled
                        and the AML method is traced every time it's executed.
                        "1" means this feature is enabled and the AML method
                        will only be traced during the next execution.
                        "disabled" means this feature is disabled.
                        Users can enable/disable this debug tracing feature by
                        "echo string > /sys/module/acpi/parameters/trace_state".
                        "string" should be one of "enable", "disable" and "1".

Like that you could increase a specific function to a specific debug
level without getting Mega Bytes of output and you might be able to read
out data without rebooting and re-overriding the DSDT...

   Thomas



