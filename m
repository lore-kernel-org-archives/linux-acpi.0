From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Thu, 22 Apr 2010 10:21:28 +0200
Message-ID: <1271924488.3790.25.camel@flunder>
References: <1271687130.26267.147.camel@pancake>
	 <p2r71cd59b01004190846m29f82672w93966b499aa917cf@mail.gmail.com>
	 <1271746353.16585.9.camel@flunder>
	 <i2r71cd59b01004200021p9a45af39y94c007edecb47884@mail.gmail.com>
	 <s2o71cd59b01004200030jfaa10a4bs81e937d2e50b15b0@mail.gmail.com>
	 <1271762498.1537.215.camel@pancake>
	 <m2i71cd59b01004200509ye8fa593xc7bd5b201d484046@mail.gmail.com>
	 <1271853961.1537.1781.camel@pancake> <20100421133305.GA28710@srcf.ucam.org>
	 <1271860206.1537.1914.camel@pancake>  <20100421143239.GA484@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TDZd5qYg/gdvwF2Yp9y1"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20100421143239.GA484@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--=-TDZd5qYg/gdvwF2Yp9y1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

> > If that's correct so far, couldn't I just print the EC event code in
> > acpi_ec_sync_query and see what it's spitting out on hotkey press?
> Yes, that should work.
I tried exactly that, and one could say that it was 50% successful. One
of the hotkeys triggers an EC event 0x95, which should lead to the following
ACPI call chain:

// upper hotkey (touchpad)
Method (_Q95, 0, NotSerialized)
{
	Store (0x95, P80H)
	\_SB.WMI2.CMD3 (0x86)
}

Method (CMD3, 1, NotSerialized)
{
	CMD0 (0x19, 0x01, 0x01, 0x01, Arg0)
}

Method (CMD0, 5, Serialized)
{
	If (LAnd (ERQ0, LEqual (Arg2, 0x01)))
	{
		Store (Arg0, EVID)
		Store (Arg1, ACID)
		Store (Arg4, DA01)
		Notify (\_SB.WMI2, 0x80)
	}
	Else
	{
		Acquire (MCD0, 0xFFFF)
		UWED (Arg0, Arg1, Arg4)
		Release (MCD0)
	}
}

So it would be all joy and happiness if it weren't for the fact that
ERQ0 is initialized to zero and is never changed anywhere else.. I'll
give the VPC0._CFG method a try later today and see if that changes
anything.

What's also confusing is that while there's an EC register (0xE6) which
nicely reflects all of the hotkeys' state as a bitmask, one of them
doesn't trigger an EC event. I'm reluctant to just write stuff to the EC
registers, but maybe one of you can make some sense of the attached
hexdump - it says "SANYO" somewhere in there, does that ring a bell?

Since I've seen that lenovo-sl-laptop also just uses polling at 5 Hz to
handle the hotkeys, I'm sort of leaning towards that solution now..

Florian

--=-TDZd5qYg/gdvwF2Yp9y1
Content-Disposition: attachment; filename="button_both.hex"
Content-Type: text/plain; name="button_both.hex"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000010  00 00 00 00 00 00 00 00  00 80 16 20 53 41 4e 59  |........... SANY|
00000020  4f 00 31 33 00 00 00 00  00 00 00 00 00 00 00 00  |O.13............|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 08 00 00 00  |................|
00000040  82 03 00 75 40 00 00 00  00 00 00 00 00 00 00 00  |...u@...........|
00000050  00 00 00 00 00 00 00 00  33 2d 00 00 00 00 00 00  |........3-......|
00000060  00 00 00 00 01 11 05 05  00 00 01 11 00 00 00 00  |................|
00000070  00 45 00 14 00 c0 00 4a  09 77 00 00 02 30 00 00  |.E.....J.w...0..|
00000080  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000000a0  00 0a 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
000000b0  00 00 00 00 00 00 00 00  90 00 00 00 00 00 03 fd  |................|
000000c0  00 8b fb f1 14 1f 1d 00  00 00 00 00 00 00 00 00  |................|
000000d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
000000e0  20 1c 00 00 00 00 c2 00  00 80 00 00 00 00 00 00  | ...............|
000000f0  00 00 00 00 fc 22 00 00  00 00 00 00 00 00 00 00  |....."..........|
00000100

--=-TDZd5qYg/gdvwF2Yp9y1--

