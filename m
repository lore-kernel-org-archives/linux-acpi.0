From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ASL issues on HP machine
Date: Tue, 29 Aug 2017 16:03:51 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E6084B2@ORSMSX110.amr.corp.intel.com>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37E606A79@ORSMSX110.amr.corp.intel.com>
 <e429849bcbe768f3de3b8d3658203a81@ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16943 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753219AbdH2QEW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Aug 2017 12:04:22 -0400
In-Reply-To: <e429849bcbe768f3de3b8d3658203a81@ruhr-uni-bochum.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Renz <David.Renz@ruhr-uni-bochum.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpi@linux.intel.com" <acpi@linux.intel.com>, "david.renz@rub.de" <david.renz@rub.de>, "Box, David E" <david.e.box@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, "linux-acpi-owner@vger.kernel.org" <linux-acpi-owner@vger.kernel.org>



> -----Original Message-----
> From: David Renz [mailto:David.Renz@ruhr-uni-bochum.de]
> Sent: Sunday, August 27, 2017 3:13 PM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: linux-acpi@vger.kernel.org; acpi@linux.intel.com; david.renz@rub.de;
> Box, David E <david.e.box@intel.com>; Schmauss, Erik
> <erik.schmauss@intel.com>; linux-acpi-owner@vger.kernel.org
> Subject: Re: ASL issues on HP machine
> 
> Am 2017-08-25 18:43, schrieb Moore, Robert:
> > I can address a couple of these immediately.
> >
> >
> > ASL_MSG_NOT_REFERENCED
> > This is seen on the HP machine.
> >
> > FAILED [LOW] AMLAsm
> > ASL_MSG_NOT_REFERENCED: Test 1, Assembler remark in line 1141 Line |
> > AML source
> > ----------------------------------------------------------------------
> > ----------
> > 01138|             Store (Buffer (0x18) {}, Local7)
> > 01139|             CreateDWordField (Local7, 0x00, A119)
> > 01140|             CreateDWordField (Local7, 0x04, A120)
> > 01141|             CreateDWordField (Local7, 0x08, A121)
> >       |                                               ^
> >       | Remark 2089: Object is not referenced    (Name [A121] is
> within
> > a
> > method [A037])
> >
> >
> > Here is the actual disassembled A037 method, found in SSDT3:
> >
> >         Method (A037, 1, NotSerialized)
> >         {
> >
> >             ... /* Some other stuff here */
> >
> >             CreateDWordField (Local7, 0x00, A119)
> >             CreateDWordField (Local7, 0x04, A120)
> >             CreateDWordField (Local7, 0x08, A121)
> >             CreateDWordField (Local7, 0x0C, A122)
> >             CreateDWordField (Local7, 0x10, A123)
> >             CreateDWordField (Local7, 0x14, A124)
> >             A119 = Local4
> >             A125 (0x3A, Local7)
> >         }
> >
> > Not only is the symbol A121 created and not referenced, all of the
> > fields A120 through A124 are not referenced.
> >
> > These are essentially "unused variables", so they have no effect on
> > operation of the method other than consuming a tiny bit more memory
> > during the execution of the method.
> >
> >
> >
> >
> > AE_AML_BUFFER_LIMIT:
> > This is seen on the HP machine.
> >
> >> [   12.291867] ACPI Error: Field [D128] at 1152 exceeds Buffer [NULL]
> >> size 160 (bits) (20150930/dsopcode-236)
> >> [   12.291875] ACPI Error: Method parse/execution failed [\HWMC]
> (Node
> >> ffff880197cb5b30), AE_AML_BUFFER_LIMIT (20150930/psparse-542)
> >
> > All of these messages are caused by either whatever driver is calling
> > the HWMC method, or the HWMC method itself.
> 
> One should be able to narrow this down to whether a driver (and which
> driver) calling the HWMC method OR the HWMC method itself being the
> reason, isn't it? But I guess this could only be done by performing
> kernel debugging on this machine to monitor the ACPI activity / event
> taking place 'live', right?
[Moore, Robert] 

For the most part, yes. The driver may be passing in a bad argument to HWMC, or the HWMC method itself is looking beyond the end of what is in fact a well-formed argument.


> 
> 
> > The exact ASL statement
> > showing the problem is this:
> >
> >
> >         CreateField (Arg1, 0x80, 0x0400, D128)
> >
> >
> > The input buffer (Arg1) is 160 bits, but this CreateField statement is
> > attempting to create a field starting at bit offset 0x80 (bit 128) for
> > length 0x400 (1024). This in fact goes way beyond the size of the
> > input buffer (out to bit 0x480, which is decimal 1152). Of course, the
> > ACPICA interpreter detects this and appropriately aborts the method.
> >
> > I cannot speak any further to this problem because it is either a
> > firmware or a driver problem. In either case, the vendor should be
> > notified.
> 
> But this is not my task as a customer, don't you think so? The easiest
> way to shed some light on this would be to send my system's dumped ACPI
> code to HP, so that they can check whether this is the code which should
> be on my machine, isn't it? And I would assume that HP won't do that if
> some custome requests them to do so, but they surely wouldn't refuse
> this request if someone from the Intel ACPI team would approach them.
[Moore, Robert] 

We develop the ACPICA OS-independent code in our group. We are not a customer service organization, and we have little contact with HP itself. We cannot offer help in this area.

The accepted path is to report issues like this to the computer vendor, in this case HP.



> 
> 
> 
> Kinds regards
> 
> David Renz
