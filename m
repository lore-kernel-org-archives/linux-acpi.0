From: Thawan Kooburat <kthawan@gmail.com>
Subject: Re: Questions about ACPI and PCI interrupt routing
Date: Sun, 3 Oct 2010 12:14:04 -0500
Message-ID: <AANLkTimHKWSomkH7DDNJdu24M83w_dKEjhmYiuMnH=_F@mail.gmail.com>
References: <AANLkTinoAuRE5nmwpUo9gjc-qda6y08gEZxEUvOkN2GL@mail.gmail.com>
	<alpine.LFD.2.00.1010010229120.7033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42199 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030Ab0JCROG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Oct 2010 13:14:06 -0400
Received: by ewy23 with SMTP id 23so1629292ewy.19
        for <linux-acpi@vger.kernel.org>; Sun, 03 Oct 2010 10:14:04 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010010229120.7033@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len,

Thank you very much for your response.

=46or unloading drivers and re-probing devices, I found that hotpluggin=
g
is very useful if the bus controller is compatible. However, I
discovered that a new device does not work properly after using rescan
because the kernel try to setup an interrupt using the old routing
information.

Is it possible to re-configure interrupt via ACPI? My current
understanding is that ACPI layer is configured during boot process by
reading various tables and create handlers for various method to
handle devices. So my initial thought is that routing via IOAPIC is a
simpler model and easier to tackle at first.

Any suggestion is welcome.

Cheers

On Fri, Oct 1, 2010 at 1:33 AM, Len Brown <lenb@kernel.org> wrote:
>> Short:
>> Is it possible to use static interrupt routing on a machine that
>> support configurable interrupt (via PCI Link Device)? So that kernel
>> will go to IOAPIC chip directly instead of using ACPI layer (such as
>> _CRS method) to manage the interrupt
>>
>> Long:
>> I am trying to resume a kernel in a machine with different hardware
>> which results in many hardware miss match problem. Right now I am
>> looking into the interrupt issue. The machines I am testing support
>> different interrupt routing model (Dynamic and Static). I am not sur=
e
>> if a machine that support dynamic routing will also support static
>> routing or not. So is it possible to force the kernel to use only
>> static model only? Bypassing ACPI layer has better chance of success
>> because I think that the resume kernel does not have a correct ACPI
>> handler to deal with the new device.
>>
>> My understanding may be incorrect because I just read a portion of
>> ACPI spec and the kernel source that related to this issue.
>
> This doesn't make any sense.
>
> Interrupt routing configuration reflects wires on the motherboard.
> If you resume a kernel image on hardware with different wires
> than were you suspended, all is lost.
>
> To do something like this, you have to un-configure
> interrupts completely, and then re-probe your devices
> when you resume on changed hardware. =A0ie. unload all your drivers.
>
> cheers,
> Len Brown, Intel Open Source Technoloy Center
>



--=20
Thawan Kooburat

Graduate Student
Department of Computer Science
UW-Madison
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
