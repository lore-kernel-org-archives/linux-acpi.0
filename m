From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Devel] Reserved method has too many arguments (_OSC requires 4)
Date: Mon, 15 Mar 2010 10:28:54 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085859FFA03E@orsmsx503.amr.corp.intel.com>
References: <201003121500.53220.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:26014 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965538Ab0COR25 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Mar 2010 13:28:57 -0400
In-Reply-To: <201003121500.53220.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "devel@acpica.org" <devel@acpica.org>, "Lin, Ming M" <ming.m.lin@intel.com>


Thomas,

Looking closely at the ASL code for _OSC that you provided, I'm afraid that the control method is botched beyond all hope.


Here is the definition of _OSC:

Arguments: (4)
Arg0 - A Buffer containing a UUID
Arg1 - An Integer containing a Revision ID of the buffer format
Arg2 - An Integer containing a count of entries in Arg3
Arg3 - A Buffer containing a list of DWORD capabilities


Analyzing the method:

>Method (_OSC, 5, NotSerialized)
>{
>   Store (Arg3, Local0)
>   Multiply (Local0, 0x04, Local1)

Attempting to convert a DWORD count to a BYTE count. It is Arg2 that contains the count, not Arg3.


>   Name (BUF1, Buffer (Local1) {})
>   Store (Arg4, BUF1)

Attempting to copy the input buffer. It is Arg3 that contains the input buffer, not Arg4. 


>   Store (Zero, Local1)
>   Store (Zero, Local2)
>   While (Local0)
>   {

Attempt to walk the entire input buffer, by DWORDs. Local0 incorrectly contains Arg3, should the count -- Arg2.


>       Multiply (Local1, 0x04, Local2)
>       CreateDWordField (BUF1, Local2, CAPB)

Create a named object (CAPB) within a loop. This will fail on the second iteration of the loop -- i.e., on the second DWORD.


>       If (Arg2)
>       {
>           If (LEqual (Local1, Zero))
>           {
>               And (CAPB, 0xFFFFFFFC)

gr.asl    20:     And (CAPB, 0xFFFFFFFC)
Warning  1106 -     ^ Result is not used, operator has no effect


>           }
>       }
>       Increment (Local1)
>       Decrement (Local0)
>   }
>   Return (BUF1)
>}


Even if the code would actually execute, it doesn't do anything.

Also, the UUID is never checked.

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
