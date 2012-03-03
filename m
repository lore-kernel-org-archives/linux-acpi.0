From: joeyli <jlee@suse.com>
Subject: Re: hp-wmi is not notified to run hotkey query...
Date: Sat, 03 Mar 2012 14:31:24 +0800
Message-ID: <1330756284.6207.55.camel@linux-s257.site>
References: <CAHJdJgOwx0MdgZdUhQ3NzK99iW9bwWUFdswhJD+G9KSm_d3+xw@mail.gmail.com>
	 <1329816650.5525.176.camel@linux-s257.site>
	 <CAHJdJgNq8taDN0ERJaxGF43NnMmeOYY_bVcWTzzfSMTYhHfKww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:58928 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab2CCGcs (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Sat, 3 Mar 2012 01:32:48 -0500
In-Reply-To: <CAHJdJgNq8taDN0ERJaxGF43NnMmeOYY_bVcWTzzfSMTYhHfKww@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kyle Evans <kevans@android-x86.org>
Cc: linux-acpi@vger.kernel.org

Sorry for I am late reply...

=E6=96=BC =E5=9B=9B=EF=BC=8C2012-02-23 =E6=96=BC 12:03 -0500=EF=BC=8CKy=
le Evans =E6=8F=90=E5=88=B0=EF=BC=9A
> Thank you Joey for sharing these debug methods.
>=20
> > You might need check those buttons emit Q event or WMI event.
> >
> > watch -n 1 cat /sys/firmware/acpi/interrupts/gpe_all
> > watch -n 1 cat /sys/firmware/acpi/interrupts/gpe[0123][0123456789AB=
CDEF]
> >
> > The value should increased when you press hotkey.
> > Then reference Corentin's article: http://lwn.net/Articles/391230/
> >
> I found that nothing happens in gpe_all when I push a hotkey button. =
I
> also found that GPE03 calls _Q15. _Q15 is the wireless switch method,
> which I have reprogrammed to notify hp-wmi of a keypress. Where is it
> defined that GPE03 runs method _Q15?
>=20

Normally, you can check the _GPE number EC device in DSDT:

        Device (EC0)
        {
            Name (_HID, EisaId ("PNP0C09"))
            Name (_UID, One)
		...
            Name (_GPE, 0x03)	<--- here, assume EC link to 0x03

Per my understand, EC firmware will set the value '15' to a EC register=
 then
emit a SCI event through 0x03. The acpi/ec.c will handle the event and
query the '15' value from EC by query command.
After got '15', acpi/ec.c will find out the handler for _Q15 then execu=
te it.

So, EC firmware should set the value '15' to register then wait acpi/ec=
=2Ec to
query it.

> > Use wmidump to parse out wmi, find out the wmi event we might want =
to
> > listen, the flags should has ACPI_WMI_EVENT.
> >
> > Then, the hard thing is we need try to poke and try to reverse engi=
neer
> > to GUESS the input/output format from event.
> I did not run wmidump because first, it was not installed, and second=
,
> because I have determined that the wmi component works.
>=20
> > If the EC emit Q event when press hotkey, you can enable acpi debug=
 log:
> > acpi.debug_level=3D0x0000000F acpi.debug_layer=3D0xffffffff log_buf=
_len=3D5M
> >
> > To monitor which method does it run when you press hotkey.
> The EC not emitting a Q event is indeed my problem. It should run
> method _Q16, which is defined to notify wmi of a keypress.
>=20

Yes, that strange because the value of gpe_all (or gpe03?) didn't
increase when press function key.
That means EC didn't emit SCI when key press.

> > And, it's also possibility for EC direct emit scancode, you can use=
:
> > showkey command to grub it or look at dmesg should has some message=
s.
> The way the DSDT is written, this is not the case. However, this may
> be something to look at since the EC is the one that reads the button
> via SMBus. I can read the internal code via ec_read(0xA2,tmp), a.k.a
> QBBB.
>=20
>=20
> Here is my current thinking, something in the EC should trigger metho=
d

Yes!

> _Q16. Ideally, SMBus should do it when it receives the button code.
> Unfortunately, that function looks like it started with ACPIspec-2
> section 5.6.2.2.2. Although the manufacturer's website indicates the
> EC, ENE KB3926 supports ACPI v2, my dsdt.dsl only indicates ACPI v1.
> Another possibility, although probably not, is that the buttons also
> trigger a GPIO when one is pressed and that the correct GPIO pin need=
s
> to be programmed correctly. My final thought is to do polling in the
> EC instead of in the kernel by programming one of the GP Timers to
> check for a button press and emit a wmi event in such a case.
>=20
> The problem I face now is that the GPIO pin configuration is at
> 0xFCxx, and the GPT configuration is at 0xFExx, neither of which can
> be accessed with ec_read/write, as it is confined to 0xFFxx. Maybe
> there is another function that I do not find?
>=20

Sorry for I have no idea.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
