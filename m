From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: ACPI bytecode hardware registers access
Date: Wed, 7 Feb 2007 12:12:47 +0800
Message-ID: <3877989d0702062012g8556231qb169d8228386a3e7@mail.gmail.com>
References: <45C640CF.2090205@assembler.cz>
	 <3877989d0702050003w3e0be4d3q9c475d2c6706f6a8@mail.gmail.com>
	 <45C7415D.9030409@assembler.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:19038 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965161AbXBGEMs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Feb 2007 23:12:48 -0500
Received: by an-out-0708.google.com with SMTP id b33so75059ana
        for <linux-acpi@vger.kernel.org>; Tue, 06 Feb 2007 20:12:47 -0800 (PST)
In-Reply-To: <45C7415D.9030409@assembler.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rudolf Marek <r.marek@assembler.cz>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

Is your ioport included in the microsoft's list being blocked by XP?
Please give me an example (acpidump output from a real box)
that demonstrates ACPI is missing something which must be done
through native driver. I'm wondering the designer of the box should
already known AML code will directly access these ioport. why they
needs some other native driver to access same set of ioport at same
time with acpi. It sounds like obvious broken design.  So my real
question is the native driver is really wanted by the platform
designer? As a hacker, it make senses to discover more
hardware/platform features. But do these features make sense to the
designer of the box.

On 2/5/07, Rudolf Marek <r.marek@assembler.cz> wrote:
> Hello,
>
> To all:
> Please continue CCing me and the lm-sensors list thanks.
>
> Luming Yu wrote:
> > Yes, that is bad to simultaneously access same hardware by ACPI and
> > native drivers without coordination. But the problem is if nativer
> > driver is really needed with the existence of the ACPI support for
> > that device?
>
> Yes for example, BIOS will export though ACPI just one temperature _TMP but the
> chip monitors voltages and more temps etc etc. So from the lm-sensors point of
> view the answer is yes we need a full driver for hardware monitoring.
>
> > Do you know the features that are NOT supported by ACPI?
>
> Yes as I wrote above - the voltages, fan speeds, various types of alarms...
>
> Instead of one temperature reading, I got 9 voltage readings, 3 temps, 5 fans
> etc etc
>
> > Probably, just writing a acpi driver for SMBus controler could solve
> > this problem completely. Just my intuition. Please correct me if I'm
> > wrong.
>
> Problem is that the device manufacturers may do what they want in ACPI bytecode.
>   We cannot expect them to implement smbus bus control as specified in the
> specs. They just drive the registers on their own.
>
> What I'm trying to implement is the ACPI isolation from selected hardware
> somehow, because the ACPI bytecode can contain code that modifies virtually any
> hardware in the system without the clue what others drivers do.
>
> Even the windows don't like it:
> http://www.microsoft.com/whdc/system/pnppwr/powermgmt/BIOSAML.mspx
> (I/O Ports Blocked from BIOS AML)
>
> Please help me find the solution.
>
> Thanks,
> Rudolf
>
