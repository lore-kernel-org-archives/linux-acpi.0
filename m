From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPI: update debug parameter documentation
Date: Wed, 30 Jul 2008 10:46:52 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3BFA441@orsmsx415.amr.corp.intel.com>
References: <20080729214338.27086.27534.stgit@tigger.helgaas> <200807301205.24322.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37073 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013AbYG3RrZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2008 13:47:25 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200807301205.24322.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org

>(Unrelated to the patch itself):
>warn and error should be eleminated.
>Warn/error as debug messages must never be used. ACPI_ERROR and
>ACPI_EXCEPTION have to be used instead.
>As some of these have slipped into kernel drivers again, those must
>be reverted first, then (not sure whether it works that simple, Bob?)
>they could get removed from ACPICA code to prevent people from
mis-using
>those.

Yes, I believe that these are obsolete and should be removed. I'll put
it on the list to investigate and remove if necessary.

Bob


>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de]
>Sent: Wednesday, July 30, 2008 3:05 AM
>To: Bjorn Helgaas
>Cc: Andi Kleen; linux-acpi@vger.kernel.org; Moore, Robert
>Subject: Re: [PATCH] ACPI: update debug parameter documentation
>
>Hi,
>
>the patch should be fine, just a little comment below.
>
>On Tuesday 29 July 2008 23:43:56 Bjorn Helgaas wrote:
>> Reformat acpi.debug_layer and acpi.debug_level documentation so it's
>> readable, add some clues about how to figure out the mask bits that
>> enable a given ACPI_DEBUG_PRINT statement, and include a couple
useful
>> examples.
>>
>> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>> ---
>>
>>  Documentation/kernel-parameters.txt |   94
>> +++++++++++++++++++++++++---------- 1 files changed, 67
insertions(+), 27
>> deletions(-)
>>
>>
>> diff --git a/Documentation/kernel-parameters.txt
>> b/Documentation/kernel-parameters.txt index 3cba6ed..76b2e97 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -200,37 +200,77 @@ and is between 256 and 4096 characters. It is
>defined
>> in the file acpi.debug_layer=	[HW,ACPI]
>>  			Format: <int>
>>  			Each bit of the <int> indicates an ACPI debug
layer,
>> -			1: enable, 0: disable. It is useful for boot
time
>> -			debugging. After system has booted up, it can be
set
>> -			via /sys/module/acpi/parameters/debug_layer.
>> -			CONFIG_ACPI_DEBUG must be enabled for this to
produce any
>output.
>> -			Available bits (add the numbers together) to
enable debug
>output
>> -			for specific parts of the ACPI subsystem:
>> -			0x01 utilities 0x02 hardware 0x04 events 0x08
tables
>> -			0x10 namespace 0x20 parser 0x40 dispatcher
>> -			0x80 executer 0x100 resources 0x200 acpica
debugger
>> -			0x400 os services 0x800 acpica disassembler.
>> -			The number can be in decimal or prefixed with 0x
in hex.
>> -			Warning: Many of these options can produce a lot
of
>> -			output and make your system unusable. Be very
careful.
>> +			which corresponds to the _COMPONENT definition
in
>> +			ACPI source files.  After system has booted,
this mask
>> +			can be set via
/sys/module/acpi/parameters/debug_layer.
>> +
>> +			CONFIG_ACPI_DEBUG must be enabled for this to
produce
>> +			any output.  The number can be in decimal or
prefixed
>> +			with 0x in hex.  Some of these options produce
so much
>> +			output that the system is unusable.
>> +
>> +			The following are some of the global components
>> +			defined by the ACPI CA and the Linux OSPM:
>> +				0x01 utilities
>> +				0x02 hardware
>> +				0x04 events
>> +				0x08 tables
>> +				0x10 namespace
>> +				0x20 parser
>> +				0x40 dispatcher
>> +				0x80 executer
>> +			       0x100 resources
>> +			       0x200 ACPI CA debugger
>> +			       0x400 OS services
>> +			       0x800 ACPI CA disassembler
>> +			     0x40000 battery
>> +			     0x80000 button
>> +			    0x200000 fan
>> +			    0x400000 PCI
>> +			  0x10000000 bay
>> +
>> +			Many others, e.g., ACPI_BUS_COMPONENT and
>> +			ACPI_AC_COMPONENT, are defined by the Linux OSPM
and
>> +			individual drivers.
>> +
>> +			For debugging PCI/_PRT issues (PCI, info msgs):
>> +			    acpi.debug_layer=0x400000
acpi.debug_level=0x10
>> +			For ACPI hardware issues (hardware, all msgs):
>> +			    acpi.debug_layer=0x2
acpi.debug_level=0xffffffff
>>
>>  	acpi.debug_level=	[HW,ACPI]
>>  			Format: <int>
>>  			Each bit of the <int> indicates an ACPI debug
level,
>> -			1: enable, 0: disable. It is useful for boot
time
>> -			debugging. After system has booted up, it can be
set
>> -			via /sys/module/acpi/parameters/debug_level.
>> -			CONFIG_ACPI_DEBUG must be enabled for this to
produce any
>output.
>> -			Available bits (add the numbers together) to
enable
>different
>> -			debug output levels of the ACPI subsystem:
>> -			0x01 error 0x02 warn 0x04 init 0x08 debug object
>> -			0x10 info 0x20 init names 0x40 parse 0x80 load
>> -			0x100 dispatch 0x200 execute 0x400 names 0x800
operation
>region
>> -			0x1000 bfield 0x2000 tables 0x4000 values 0x8000
objects
>> -			0x10000 resources 0x20000 user requests 0x40000
package.
>> -			The number can be in decimal or prefixed with 0x
in hex.
>> -			Warning: Many of these options can produce a lot
of
>> -			output and make your system unusable. Be very
careful.
>> +			which corresponds to the level in an
ACPI_DEBUG_PRINT
>> +			statement.  After system has booted up, this
mask
>> +			can be set via
/sys/module/acpi/parameters/debug_level.
>> +
>> +			CONFIG_ACPI_DEBUG must be enabled for this to
produce
>> +			any output.  The number can be in decimal or
prefixed
>> +			with 0x in hex.  Some of these options produce
so much
>> +			output that the system is unusable.
>Maybe a pointer to log_buf_len to increase buffers if there is too much
>output
>could help people to still find early boot messages:
>
>                        If early boot messages are not available
anymore
>                        because of too much ACPI debug output, have a
look
>                        at the log_buf_len= boot param to increase the
>                        log buffer.
>
>> +
>> +			The following global components are defined by
the
>> +			ACPI CA:
>> +			       0x01 error
>> +			       0x02 warn
>(Unrelated to the patch itself):
>warn and error should be eleminated.
>Warn/error as debug messages must never be used. ACPI_ERROR and
>ACPI_EXCEPTION have to be used instead.
>As some of these have slipped into kernel drivers again, those must
>be reverted first, then (not sure whether it works that simple, Bob?)
>they could get removed from ACPICA code to prevent people from
mis-using
>those.
>
>IMO a GPE level would make sense, but this is some extra work...
>
>       Thomas
>> +			       0x04 init
>> +			       0x08 debug object
>> +			       0x10 info
>> +			       0x20 init names
>> +			       0x40 parse
>> +			       0x80 load
>> +			      0x100 dispatch
>> +			      0x200 execute
>> +			      0x400 names
>> +			      0x800 operation region
>> +			     0x1000 bfield
>> +			     0x2000 tables
>> +			     0x4000 values
>> +			     0x8000 objects
>> +			    0x10000 resources
>> +			    0x20000 user requests
>> +			    0x40000 package
>>
>>  	acpi_pm_good	[X86-32,X86-64]
>>  			Override the pmtimer bug detection: force the
kernel
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

