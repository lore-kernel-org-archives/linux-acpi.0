From: joeyli <jlee@suse.com>
Subject: Re: hp-wmi is not notified to run hotkey query...
Date: Tue, 21 Feb 2012 17:30:50 +0800
Message-ID: <1329816650.5525.176.camel@linux-s257.site>
References: <CAHJdJgOwx0MdgZdUhQ3NzK99iW9bwWUFdswhJD+G9KSm_d3+xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:42818 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab2BUJbp (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Tue, 21 Feb 2012 04:31:45 -0500
In-Reply-To: <CAHJdJgOwx0MdgZdUhQ3NzK99iW9bwWUFdswhJD+G9KSm_d3+xw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kyle Evans <kevans@android-x86.org>
Cc: linux-acpi@vger.kernel.org

Hi Kayle,=20

=E6=96=BC =E4=BA=8C=EF=BC=8C2012-02-14 =E6=96=BC 11:47 -0500=EF=BC=8CKy=
le Evans =E6=8F=90=E5=88=B0=EF=BC=9A
> Hello, I have an HP tx2500 with some bezel buttons that are not
> working. HP tabletPC's are notorious for this. I have discovered why
> they are not working (hp-wmi is not getting the notification to query
> them) and I have managed to insert some code into the DSDT that will
> cause hp-wmi to successfully read these keys when the lid is closed. =
I
> have inserted this same code into every _Q?? method from 01-8F,
> including those previously undefined, but no dice. I have also
> extracted the DSDT from Windows Vista, decompiled it, compared it to
> the one I extracted from Linux (several small differences), recompile=
d
> it and ran it. That didn't get it done either.
>=20

You might need check those buttons emit Q event or WMI event.

watch -n 1 cat /sys/firmware/acpi/interrupts/gpe_all
watch -n 1 cat /sys/firmware/acpi/interrupts/gpe[0123][0123456789ABCDEF=
]

The value should increased when you press hotkey.
Then reference Corentin's article: http://lwn.net/Articles/391230/

Use wmidump to parse out wmi, find out the wmi event we might want to
listen, the flags should has ACPI_WMI_EVENT.

Then, the hard thing is we need try to poke and try to reverse engineer
to GUESS the input/output format from event.

Sorry for I didn't have good experience on reverse engineer.


If the EC emit Q event when press hotkey, you can enable acpi debug log=
:
acpi.debug_level=3D0x0000000F acpi.debug_layer=3D0xffffffff log_buf_len=
=3D5M

To monitor which method does it run when you press hotkey.


And, it's also possibility for EC direct emit scancode, you can use:
showkey command to grub it or look at dmesg should has some messages.

> So basically, this is a BIOS problem that Windows works around. I do
> not know enough about the hardware/BIOS to determine whether or not
> this is something that can still be fixed in the DSDT, or something
> that would have to be fixed in the kernel. For a BIOS fix, I suspect
> the Embedded Controller needs to be programmed in some way, along wit=
h
> a modified dsdt. For a kernel fix, I suspect Windows either polls the
> WMI query, programs the EC every boot, or gets the signal some other
> way (e.g. PNP0C09).
>=20
> A brief description of how these hotkeys operate:
> The EmbeddedController, PNP0C09, houses the internal button register,
> QBBB, that stores the internal key code. When hp-wmi, PNP0C14,
> performs the query, QBBB is tested for the button pressed and the
> appropriate scancode is wrote to the memory location that is
> subsequently read.
>=20
> I have what I believe to be an accurate MB schematic, which indicates
> that the embedded controller is from ENE, chip KB3926, and I have
> found data sheets for similar EC's. This is something that I work on
> in my spare time, so I would be grateful if someone could share some
> knowledge on the subject, or kindly point me to someone who might be
> able to help.
>=20
> Thanks,
> Kyle

Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
