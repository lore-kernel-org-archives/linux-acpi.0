From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Improve acpi_dbg_level= documentation
Date: Wed, 18 Apr 2007 16:26:20 -0400
Message-ID: <200704181626.21213.lenb@kernel.org>
References: <200704181221.37897.ak@suse.de> <20070418080812.0f7f559a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53115 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992609AbXDRU1p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Apr 2007 16:27:45 -0400
In-Reply-To: <20070418080812.0f7f559a.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org

On Wednesday 18 April 2007 11:08, Randy Dunlap wrote:
> On Wed, 18 Apr 2007 12:21:37 +0200 Andi Kleen wrote:
> 
> > 
> > First it was documented twice.
> 
> acpi_dbg_layer and
> acpi_dbg_level are different.

Note that debug_level and debug_layer are available
in sysfs and are self_documenting.

(though in looking at it, I think it is incorrect for
sysfs to use debug_level and debug_layer instead of
acpi_dbg_level and acpi_dbg_layer, which would match
the actual name of the kernel boot parameters)

-Len

lenb@nx6325:~> cat /sys/module/acpi/parameters/debug_level
Description                     Hex        SET
ACPI_LV_ERROR                   0x00000001 [*]
ACPI_LV_WARN                    0x00000002 [*]
ACPI_LV_INIT                    0x00000004 [*]
ACPI_LV_DEBUG_OBJECT            0x00000008 [*]
ACPI_LV_INFO                    0x00000010 [ ]
ACPI_LV_INIT_NAMES              0x00000020 [ ]
ACPI_LV_PARSE                   0x00000040 [ ]
ACPI_LV_LOAD                    0x00000080 [ ]
ACPI_LV_DISPATCH                0x00000100 [ ]
ACPI_LV_EXEC                    0x00000200 [ ]
ACPI_LV_NAMES                   0x00000400 [ ]
ACPI_LV_OPREGION                0x00000800 [ ]
ACPI_LV_BFIELD                  0x00001000 [ ]
ACPI_LV_TABLES                  0x00002000 [ ]
ACPI_LV_VALUES                  0x00004000 [ ]
ACPI_LV_OBJECTS                 0x00008000 [ ]
ACPI_LV_RESOURCES               0x00010000 [ ]
ACPI_LV_USER_REQUESTS           0x00020000 [ ]
ACPI_LV_PACKAGE                 0x00040000 [ ]
ACPI_LV_ALLOCATIONS             0x00100000 [ ]
ACPI_LV_FUNCTIONS               0x00200000 [ ]
ACPI_LV_OPTIMIZATIONS           0x00400000 [ ]
ACPI_LV_MUTEX                   0x01000000 [ ]
ACPI_LV_THREADS                 0x02000000 [ ]
ACPI_LV_IO                      0x04000000 [ ]
ACPI_LV_INTERRUPTS              0x08000000 [ ]
ACPI_LV_AML_DISASSEMBLE         0x10000000 [ ]
ACPI_LV_VERBOSE_INFO            0x20000000 [ ]
ACPI_LV_FULL_TABLES             0x40000000 [ ]
ACPI_LV_EVENTS                  0x80000000 [ ]
--
debug_level = 0x0000000F (* = enabled)

lenb@nx6325:~> cat /sys/module/acpi/parameters/debug_layer
Description                     Hex        SET
ACPI_UTILITIES                  0x00000001 [*]
ACPI_HARDWARE                   0x00000002 [*]
ACPI_EVENTS                     0x00000004 [*]
ACPI_TABLES                     0x00000008 [*]
ACPI_NAMESPACE                  0x00000010 [*]
ACPI_PARSER                     0x00000020 [*]
ACPI_DISPATCHER                 0x00000040 [*]
ACPI_EXECUTER                   0x00000080 [*]
ACPI_RESOURCES                  0x00000100 [*]
ACPI_CA_DEBUGGER                0x00000200 [*]
ACPI_OS_SERVICES                0x00000400 [*]
ACPI_CA_DISASSEMBLER            0x00000800 [*]
ACPI_COMPILER                   0x00001000 [*]
ACPI_TOOLS                      0x00002000 [*]
ACPI_ALL_DRIVERS                0xFFFF0000 [*]
--
debug_layer = 0xFFFF3FFF ( * = enabled)


> But the added text is Good.
> 
> > Since this is a fairly important option document it properly.
> > I kept myself looking for this information again and again.
> > 
> > In particular the individual bits are fairly important. And add some 
> > warnings.
> > 
> > Signed-off-by: Andi Kleen <ak@suse.de>
> > 
> > Index: linux/Documentation/kernel-parameters.txt
> > ===================================================================
> > --- linux.orig/Documentation/kernel-parameters.txt
> > +++ linux/Documentation/kernel-parameters.txt
> > @@ -187,13 +187,16 @@ and is between 256 and 4096 characters. 
> >  			1: enable, 0: disable. It is useful for boot time
> >  			debugging. After system has booted up, it can be set
> >  			via /proc/acpi/debug_layer.
> > -
> > -	acpi_dbg_level=	[HW,ACPI]
> > -			Format: <int>
> > -			Each bit of the <int> indicates an ACPI debug level,
> > -			1: enable, 0: disable. It is useful for boot time
> > -			debugging. After system has booted up, it can be set
> > -			via /proc/acpi/debug_level.
> > +			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
> > +			Available bits (add the numbers together) to enable debug output
> > +			for specific parts of the ACPI subsystem:
> > +			1 utilities 2 hardware 4 events 8 tables 
> > +			0x10 namespace 0x20 parser 0x40 dispatcher
> > +			0x80 executer 0x100 resources 0x200 debugger
> > +			0x400 os services
> > +			The number can be in decimal or prefixed with 0x in hex.
> > +			Warning: Many of these options can produce a lot of 
> > +			output and make your system unusable. Be very careful.
> >  
> >  	acpi_fake_ecdt	[HW,ACPI] Workaround failure due to BIOS lacking ECDT
> >  
> 
> 
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
