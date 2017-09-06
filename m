From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: ASL issues on HP machine
Date: Wed, 6 Sep 2017 05:45:30 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF3352D@SHSMSX101.ccr.corp.intel.com>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37E606A79@ORSMSX110.amr.corp.intel.com>
 <e429849bcbe768f3de3b8d3658203a81@ruhr-uni-bochum.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E6084B2@ORSMSX110.amr.corp.intel.com>
 <b31d1ad8b2cfcc274118d2b27d45ada5@ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16119 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbdIFFpe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Sep 2017 01:45:34 -0400
In-Reply-To: <b31d1ad8b2cfcc274118d2b27d45ada5@ruhr-uni-bochum.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Renz <David.Renz@ruhr-uni-bochum.de>, "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpi@linux.intel.com" <acpi@linux.intel.com>, "david.renz@rub.de" <david.renz@rub.de>, "Box, David E" <david.e.box@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, "linux-acpi-owner@vger.kernel.org" <linux-acpi-owner@vger.kernel.org>

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of David
> Renz
> Subject: Re: ASL issues on HP machine
> 
> Am 2017-08-29 18:03, schrieb Moore, Robert:
> >> -----Original Message-----
> >> From: David Renz [mailto:David.Renz@ruhr-uni-bochum.de]
> >> Sent: Sunday, August 27, 2017 3:13 PM
> >> To: Moore, Robert <robert.moore@intel.com>
> >> Cc: linux-acpi@vger.kernel.org; acpi@linux.intel.com;
> >> david.renz@rub.de;
> >> Box, David E <david.e.box@intel.com>; Schmauss, Erik
> >> <erik.schmauss@intel.com>; linux-acpi-owner@vger.kernel.org
> >> Subject: Re: ASL issues on HP machine
> >>
> >> Am 2017-08-25 18:43, schrieb Moore, Robert:
> >> > I can address a couple of these immediately.
> >> >
> >> >
> >> > ASL_MSG_NOT_REFERENCED
> >> > This is seen on the HP machine.
> >> >
> >> > FAILED [LOW] AMLAsm
> >> > ASL_MSG_NOT_REFERENCED: Test 1, Assembler remark in line 1141 Line |
> >> > AML source
> >> > ----------------------------------------------------------------------
> >> > ----------
> >> > 01138|             Store (Buffer (0x18) {}, Local7)
> >> > 01139|             CreateDWordField (Local7, 0x00, A119)
> >> > 01140|             CreateDWordField (Local7, 0x04, A120)
> >> > 01141|             CreateDWordField (Local7, 0x08, A121)
> >> >       |                                               ^
> >> >       | Remark 2089: Object is not referenced    (Name [A121] is
> >> within
> >> > a
> >> > method [A037])
> >> >
> >> >
> >> > Here is the actual disassembled A037 method, found in SSDT3:
> >> >
> >> >         Method (A037, 1, NotSerialized)
> >> >         {
> >> >
> >> >             ... /* Some other stuff here */
> >> >
> >> >             CreateDWordField (Local7, 0x00, A119)
> >> >             CreateDWordField (Local7, 0x04, A120)
> >> >             CreateDWordField (Local7, 0x08, A121)
> >> >             CreateDWordField (Local7, 0x0C, A122)
> >> >             CreateDWordField (Local7, 0x10, A123)
> >> >             CreateDWordField (Local7, 0x14, A124)
> >> >             A119 = Local4
> >> >             A125 (0x3A, Local7)
> >> >         }
> >> >
> >> > Not only is the symbol A121 created and not referenced, all of the
> >> > fields A120 through A124 are not referenced.
> >> >
> >> > These are essentially "unused variables", so they have no effect on
> >> > operation of the method other than consuming a tiny bit more memory
> >> > during the execution of the method.
> >> >
> >> >
> >> >
> >> >
> >> > AE_AML_BUFFER_LIMIT:
> >> > This is seen on the HP machine.
> >> >
> >> >> [   12.291867] ACPI Error: Field [D128] at 1152 exceeds Buffer [NULL]
> >> >> size 160 (bits) (20150930/dsopcode-236)
> >> >> [   12.291875] ACPI Error: Method parse/execution failed [\HWMC]
> >> (Node
> >> >> ffff880197cb5b30), AE_AML_BUFFER_LIMIT (20150930/psparse-542)
> >> >
> >> > All of these messages are caused by either whatever driver is calling
> >> > the HWMC method, or the HWMC method itself.
> >>
> >> One should be able to narrow this down to whether a driver (and which
> >> driver) calling the HWMC method OR the HWMC method itself being the
> >> reason, isn't it? But I guess this could only be done by performing
> >> kernel debugging on this machine to monitor the ACPI activity / event
> >> taking place 'live', right?
> > [Moore, Robert]
> >
> > For the most part, yes. The driver may be passing in a bad argument to
> > HWMC, or the HWMC method itself is looking beyond the end of what is
> > in fact a well-formed argument.
> 
> I'm familiar with 6502 and x86/x864 machine code, several programming
> languages and Linux, but I honestly admit that I don't possess much
> knowledge about the ACPI sub-system itself and the AML language/syntax.
> So apart from this concrete issue with the ACPI code on my HP machine
> which might produce unwanted effects, I appreciate the opportunity to
> extend my knowledge regarding this field (I took a look at the more than
> 900 pages of the current ACPI specifications and got the impression that
> understanding this thoroughly will probably require a considerable
> amount of time).

It's simpler than what you are mentioning.
You only need to read (in case of ACPI spec 6.2) 1-5 and 19-21.
Others are talking about the "application of ACPI" from ACPICA's point of view.
It just took me 1-2 weeks to translate these chapters into my native language.

In case of understanding ASL/AML concept, you only need to be an expert of 19.3.

> 
> 1) What is "the driver" exactly? Is it part of the ACPI sub-system?
> If you refer to a "driver", which doesn't belong to the ACPI sub-system,
> then a driver calling the HWC method would imply that you refer to a
> driver running on an OS with ACPI support being enabled, is this
> correct?
> In this case kernel debugging would show (assuming this would not be
> prevented) the interaction between this driver / the OS and the ACPI
> sub-system, right?
> 
> 2) Is it correct that the ACPI sub-system is active / running and able
> to access other parts of the system no matter whether the OS supports it
> or not (or whether one would disable the support)? This is what two
> persons possessing a profound knowledge about low-level hardware topics
> said, so I'd be curious to hear a definite statement on this from
> someone who actively works on the ACPI development.
> 
> 
> I would assume that simply performing ACPI debugging has its limits when
> trying to narrow down issues like this. Both VirtualBox and QEMU support
> specifying individual ACPI tables for a VM - So wouldn't it be the most
> simple solution to specify the according / affected table(s) (all of
> them can be downloaded from my GoogleDrive folder) to a VM running a
> Linux system with a kernel customized for debugging, and then compare
> the verbose debugging output 1) with these tables specified against the
> output 2) without these tables specified?
> I can hardly imagine that the ACPI team at Intel does not have
> experience in doing so, as this is surely a well-working method to debug
> ACPI-related issues in general.
> 
> 
> 
> 3) Assuming that this ACPI code is not 'malicious code' / an 'ACPI based
> rootkit' but simply erraneous ACPI code (if this should be the case,
> then such a rootkit would surely prevent that it gets overwritten by
> performing a BIOS update), would flashing the ACPI would overwrite the
> ACPI code as well? Previously I talked with a LibreBoot developer, who
> certainly knew what he was talking about this, and he ensured me that
> certain parts of the BIOS won't be overwritten when performing a BIOS
> flash - But in this context we didn't discuss whether the ACPI code
> belongs to the parts which won't be overwritten or not, so also in this
> case a true expert's statement would definitely be appreciated. ;)

TBH, I wasn't worrying about "malicious code", I was always worrying about
The known software defects that wouldn't be reported by the community.
Many software developers (probably including you) can soon tell if a
software is buggy or not by taking a first glance at it.

Thanks and best regards
Lv

> 
> 
> > [Moore, Robert]
> >
> > We develop the ACPICA OS-independent code in our group. We are not a
> > customer service organization, and we have little contact with HP
> > itself. We cannot offer help in this area.
> >
> > The accepted path is to report issues like this to the computer
> > vendor, in this case HP.
> 
> 
> Well, I already guessed that you are not a customer service
> organization... Could you at least provide me a contact address (without
> posting it on the mailing list), so that I could forward this to a
> competent department at HP (instead of first having to contact their
> customer service)?
> 
> By the way, if the ACPI code is "OS-independent", when why should there
> be (e. g.) the keyword "linux" in my system's ACPI code?
> 
> 
> Kind regards and thanks in advance
> 
> David Renz
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
