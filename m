From: Daniel Toussaint <daniel@dmhome.net>
Subject: Re: Driver for handling SCI interrupt.
Date: Thu, 9 Feb 2012 13:24:02 +0800
Message-ID: <CADVYk4T3wAjE3qFFynbmnceLeNFSRb+M+Lq6qw2c9ncGJS6V9g@mail.gmail.com>
References: <CADVYk4RTY3=Xiw5JsiDssN9i3yo+jQw1p_i42tKrMDVH5=_ykQ@mail.gmail.com>
	<20120206145759.GA29805@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:38418 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab2BIFYE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2012 00:24:04 -0500
Received: by qafk1 with SMTP id k1so932076qaf.19
        for <linux-acpi@vger.kernel.org>; Wed, 08 Feb 2012 21:24:02 -0800 (PST)
In-Reply-To: <20120206145759.GA29805@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Thanks very much for the very helpful info.
I have added the GPE to my DSDT and now I can see the GPE counter in
/sys/firmware/acpi/interrupts increasing whenever I send an SCI.
Further more, I  found the function acpi_install_gpe_handler in the
kernel, and used it successfully to install a handler in a temporary
driver I created.
My custom device is an I2C device that I will read input from ,
whenever my gpe event occurs. Now my question is : this seems to work
without declaring a new device in the DSDT , with an HID - as you
mentioned - so can I get away with doing things this way , or would it
be bad practice ?
Thanks,


On Mon, Feb 6, 2012 at 10:57 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, Feb 06, 2012 at 11:25:20AM +0800, Daniel Toussaint wrote:
>
>> I am working on an Intel (ICH8) based system. A custom device on the system
>> emits interrupts to a GPI on the ICH8 chip. Currently, as a test, I have
>> from userspace configured the GPI we use to send a SCI. This seems to work,
>> because I get a "IRQ9 , nobody cared" message from the kernel.
>> My questions now are :
>> How do I go about and create an ACPI based driver to catch this event ? Or am
>> I searching in the wrong direction.
>> If I am right, and the driver has to go through ACPI, are changes to the
>> ACPI tables in BIOS required ?
>
> The ACPI tables should declare the device and its resources, along with
> a unique _HID() to allow the driver to bind to it. There should also be
> a _Lxx or_Exx (depending on whether it's level or edge triggered) method
> for the appropriate GPE (which is the GPIO number + 0x10 on ICH8, I
> believe) which sends a Notify to the ACPI device. It's then trivial to
> write a small Linux acpi driver which will get the notifications.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org



-- 
Gtalk: daniel.toussaint@gmail.com
Skype: supertoussi
Cell: +886-915-680-291
