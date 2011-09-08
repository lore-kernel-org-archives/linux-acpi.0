From: Oliver Schinagl <oliver@schinagl.nl>
Subject: Re: [Bug 42502] PROBLEM: USB 1.1 (and up) not working on AMD R900
 Series chipset
Date: Thu, 08 Sep 2011 02:00:39 +0200
Message-ID: <4E6805A7.7080806@schinagl.nl>
References: <bug-42502-20552@https.bugzilla.kernel.org/> <201109072200.p87M0G5V011358@demeter1.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:44277 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932103Ab1IHAAl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Sep 2011 20:00:41 -0400
Received: from [10.2.0.191] (unknown [10.2.0.191])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id D09DFE108
	for <linux-acpi@vger.kernel.org>; Thu,  8 Sep 2011 02:00:39 +0200 (CEST)
In-Reply-To: <201109072200.p87M0G5V011358@demeter1.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've uploaded an error log to the bugzilla [1] and have some questions
that probably are more suited for a mailinglist?


At first glance, the errors are identical to the 2010 acpi compiler.

A few things I do not understand however. This board is only a few
months old. The bios could be older, but more then a year hardly? Even
the 'base' bits. I'd reccon one of the new compilers would be long
available? (I know, OEM's don't like to upgrade their toolkits etc. *sigh*

Also, the 20051117 iasl only supports ACPI Specification Rev 3.0, I'd
guess it would support acpi 4.0a by now? (I think i found somewhere it
only does 2.0 actually and I guess acpi is more of a laptop thing with
the fancy stuff).

Lastly, if I get 130 errors and but still a binary as a result how can
that possibly even work? Would they even use this code 'as is' in
production stuff? I suppose a DSDT isn't that important for a Desktop
but from the way I see how buggy the uefi-bios is (for example it is
extremely slow just post-ing with USB connected, maybe related to this?)
How did this get past QA with so many errors, not even warnings.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=42502

Lastly, as Robert pointed out; according to

On 09/08/11 00:00, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=42502
> 
> 
> Robert Moore <Robert.Moore@intel.com> changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |Robert.Moore@intel.com
> 
> 
> 
> 
> --- Comment #9 from Robert Moore <Robert.Moore@intel.com>  2011-09-07 22:00:05 ---
>  *     OEM Table ID     "A M I"
>  *     OEM Revision     0x00000000 (0)
>  *     Compiler ID      "INTL"
>  *     Compiler Version 0x20051117 (537202967)
> 
> This is a version of iASL from 2005. At some point, some of the code in this
> DSDT was made illegal, and the compiler now reflects that.
> 
> Namely, this code:
> 
> Device (SATA)
> {
>     Name (_ADR, 0x00110000)
>     If (LEqual (STCL, 0x0101))
>     {
> 
> The "If" is an "executable" opcode that appears outside of a control method.
> This is now illegal ASL code.
> 
> Typically, the fix is to move this code under _SB_._INI, this method gets
> executed at table load time. But it's not always real simple to do this.
> 
