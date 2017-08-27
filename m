From: David Renz <David.Renz@ruhr-uni-bochum.de>
Subject: Re: ASL issues on HP machine
Date: Mon, 28 Aug 2017 00:12:51 +0200
Message-ID: <e429849bcbe768f3de3b8d3658203a81@ruhr-uni-bochum.de>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37E606A79@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.mail.ruhr-uni-bochum.de ([134.147.42.229]:38610 "EHLO
        out2.mail.ruhr-uni-bochum.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751342AbdH0WTm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 27 Aug 2017 18:19:42 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E606A79@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, acpi@linux.intel.com, david.renz@rub.de, "Box, David E" <david.e.box@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, linux-acpi-owner@vger.kernel.org

Am 2017-08-25 18:43, schrieb Moore, Robert:
> I can address a couple of these immediately.
> 
> 
> ASL_MSG_NOT_REFERENCED
> This is seen on the HP machine.
> 
> FAILED [LOW] AMLAsm
> ASL_MSG_NOT_REFERENCED: Test 1, Assembler remark in
> line 1141
> Line | AML source
> --------------------------------------------------------------------------------
> 01138|             Store (Buffer (0x18) {}, Local7)
> 01139|             CreateDWordField (Local7, 0x00, A119)
> 01140|             CreateDWordField (Local7, 0x04, A120)
> 01141|             CreateDWordField (Local7, 0x08, A121)
>       |                                               ^
>       | Remark 2089: Object is not referenced    (Name [A121] is within 
> a
> method [A037])
> 
> 
> Here is the actual disassembled A037 method, found in SSDT3:
> 
>         Method (A037, 1, NotSerialized)
>         {
> 
>             ... /* Some other stuff here */
> 
>             CreateDWordField (Local7, 0x00, A119)
>             CreateDWordField (Local7, 0x04, A120)
>             CreateDWordField (Local7, 0x08, A121)
>             CreateDWordField (Local7, 0x0C, A122)
>             CreateDWordField (Local7, 0x10, A123)
>             CreateDWordField (Local7, 0x14, A124)
>             A119 = Local4
>             A125 (0x3A, Local7)
>         }
> 
> Not only is the symbol A121 created and not referenced, all of the
> fields A120 through A124 are not referenced.
> 
> These are essentially "unused variables", so they have no effect on
> operation of the method other than consuming a tiny bit more memory
> during the execution of the method.
> 
> 
> 
> 
> AE_AML_BUFFER_LIMIT:
> This is seen on the HP machine.
> 
>> [   12.291867] ACPI Error: Field [D128] at 1152 exceeds Buffer [NULL]
>> size 160 (bits) (20150930/dsopcode-236)
>> [   12.291875] ACPI Error: Method parse/execution failed [\HWMC] (Node
>> ffff880197cb5b30), AE_AML_BUFFER_LIMIT (20150930/psparse-542)
> 
> All of these messages are caused by either whatever driver is calling
> the HWMC method, or the HWMC method itself.

One should be able to narrow this down to whether a driver (and which 
driver) calling the HWMC method OR the HWMC method itself being the 
reason, isn't it? But I guess this could only be done by performing 
kernel debugging on this machine to monitor the ACPI activity / event 
taking place 'live', right?


> The exact ASL statement
> showing the problem is this:
> 
> 
>         CreateField (Arg1, 0x80, 0x0400, D128)
> 
> 
> The input buffer (Arg1) is 160 bits, but this CreateField statement is
> attempting to create a field starting at bit offset 0x80 (bit 128) for
> length 0x400 (1024). This in fact goes way beyond the size of the
> input buffer (out to bit 0x480, which is decimal 1152). Of course, the
> ACPICA interpreter detects this and appropriately aborts the method.
> 
> I cannot speak any further to this problem because it is either a
> firmware or a driver problem. In either case, the vendor should be
> notified.

But this is not my task as a customer, don't you think so? The easiest 
way to shed some light on this would be to send my system's dumped ACPI 
code to HP, so that they can check whether this is the code which should 
be on my machine, isn't it? And I would assume that HP won't do that if 
some custome requests them to do so, but they surely wouldn't refuse 
this request if someone from the Intel ACPI team would approach them.



Kinds regards

David Renz
