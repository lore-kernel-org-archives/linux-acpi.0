From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Devel] Reserved method has too many arguments (_OSC requires 4)
Date: Fri, 12 Mar 2010 07:58:41 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085859F8A2C7@orsmsx503.amr.corp.intel.com>
References: <201003121500.53220.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42727 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756398Ab0CLP6m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Mar 2010 10:58:42 -0500
In-Reply-To: <201003121500.53220.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "devel@acpica.org" <devel@acpica.org>


>My other concern/question is: what exactly happens in such a case?
>Will _OSC get invoked at all?
>If yes, what will be the last argument, zero, -1?

The method will be invoked with the 4 arguments, the correct number. What will happen then is one of three things:

1) The method attempts to access the phantom fifth argument and it will then be aborted with an AE_AML_UNINITIALIZED_ARG exception.

2) The method has some other confusion about the first four arguments (given that it is already confused about the number of arguments in the first place), and does something unpredictable.

2) The method does not attempt to access the fifth argument, understands the first four arguments correctly and runs to completion correctly.


>This is not the first time I see this message.
>It would be great to get (from include/linux/kernel.h):

I've seen this suggestion before, I'll add it as something to look at -- since it goes far beyond one or two error messages.

In the meantime, the existing error message could use some improvement to clarify it, any suggestions?

Bob


>-----Original Message-----
>From: devel-bounces@acpica.org [mailto:devel-bounces@acpica.org] On Behalf
>Of Thomas Renninger
>Sent: Friday, March 12, 2010 6:01 AM
>To: linux-acpi@vger.kernel.org
>Cc: devel@acpica.org
>Subject: [Devel] Reserved method has too many arguments (_OSC requires 4)
>
>Hi,
>
>I have a laptop freezing early, acpi=off and noapic helps.
>I wonder whether this could have to do with the broken _OSC method.
>
>I cannot access the machine myself, eventually I can get more info
>if needed, but the machine is freezing really early (after ACPI
>initialization, somewhere around bringing up CPUs (possibly when
>starting PCI init already?).
>
>This is not the first time I see this message.
>It would be great to get (from include/linux/kernel.h):
>#define FW_BUG          "[Firmware Bug]: "
>#define FW_WARN         "[Firmware Warn]: "
>#define FW_INFO         "[Firmware Info]: "
>marked messages into ACPICA and blame the guys who are responsible
>for that.
>
>My other concern/question is: what exactly happens in such a case?
>Will _OSC get invoked at all?
>If yes, what will be the last argument, zero, -1?
>
>Hmm, I doubt it has to do with the freeze, but it would still be
>great if someone knowing these parts could comment what people
>with such a BIOS could expect to happen.
>
>Thanks,
>
>  Thomas
>
>Method (_OSC, 5, NotSerialized)
>{
>   Store (Arg3, Local0)
>   Multiply (Local0, 0x04, Local1)
>   Name (BUF1, Buffer (Local1) {})
>   Store (Arg4, BUF1)
>   Store (Zero, Local1)
>   Store (Zero, Local2)
>   While (Local0)
>   {
>       Multiply (Local1, 0x04, Local2)
>       CreateDWordField (BUF1, Local2, CAPB)
>       If (Arg2)
>       {
>           If (LEqual (Local1, Zero))
>           {
>               And (CAPB, 0xFFFFFFFC)
>           }
>       }
>       Increment (Local1)
>       Decrement (Local0)
>   }
>   Return (BUF1)
>}
>_______________________________________________
>Devel mailing list
>Devel@acpica.org
>http://lists.acpica.org/listinfo/devel
