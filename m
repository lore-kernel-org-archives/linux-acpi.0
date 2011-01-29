From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [RFC] merge 32/64 bits realmode wakeup code
Date: Sat, 29 Jan 2011 21:43:44 +0100
Message-ID: <4D447C00.70709@free.fr>
References: <4D41EA12.1030402@free.fr> <201101272354.00042.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:42355 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968Ab1A2Unz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Jan 2011 15:43:55 -0500
In-Reply-To: <201101272354.00042.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org

Rafael J. Wysocki a =E9crit :
> On Thursday, January 27, 2011, matthieu castet wrote:
>> Hi,
>>
>> this patch merge 32 and 64 realmode wakeup code :
>> - this mean less ifdef in code
>> - we could remove now unused field in wakeup_header (pmode_*)
>> - this allow to set the first 1 MB NX.
>>
>> Do you think it is safe on all X86 32 bit machine ?
>>
>> Matthieu
>>
>>
>> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
>=20
> It _looks_ sane, but it will require some serious testing.  I'm not s=
ure,
> though, if we can get enough testing coverage without actually commit=
ting
> that change.
>=20
> How much testing has it received so far?
>=20
Not too much only qemu with 1 and 2 core and a laptop with 1 cpu.

Please note that with this patch we can also remove the gdt, idt, ldt s=
tuff from=20
arch/x86/kernel/acpi/wakeup_32.S




Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
