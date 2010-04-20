From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Tue, 20 Apr 2010 09:21:23 +0200
Message-ID: <i2r71cd59b01004200021p9a45af39y94c007edecb47884@mail.gmail.com>
References: <1271518653.4549.186.camel@flunder>
	 <q2s71cd59b01004181221kce7c1e5cn7742b1063827ac3b@mail.gmail.com>
	 <1271687130.26267.147.camel@pancake>
	 <p2r71cd59b01004190846m29f82672w93966b499aa917cf@mail.gmail.com>
	 <1271746353.16585.9.camel@flunder>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53907 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab0DTHV0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2010 03:21:26 -0400
In-Reply-To: <1271746353.16585.9.camel@flunder>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Tue, Apr 20, 2010 at 8:52 AM, Florian Echtler <floe@butterbrot.org> wrote:
> Hello Corentin,
>
>> >> > First, I've dumped the DSDT and browsed through it. I've found a _WDT
>> >> > section, and wmidump shows:
>> >> Wow, someone actually used that tool ^^
>> >> A Quick hint would be to look at
>> >> https://patchwork.kernel.org/patch/87210/ which is basically a really
>> >> short example of what a wmi-driver is.
>> >> Just change the guid, buid/load, push some hotkeys, see dmesg, edit
>> >> the keymap, build, load, test ..
>> > Thanks for the pointer - I've given it a quick try and the driver loads
>> > successfully, however, the event doesn't seem to be triggered. I've put
>> > a printk into the eeepc_wmi_notify function, and this is seemingly never
>> > called.. although I believe this may be the right direction, as the GUID
>> > from the eeepc driver (ABBC0F72-8EA1-11D1-00A0-C90629100000) and the one
>> > from my Lenovo (ABBC0F20-8EA1-11D1-00A0-C90629100000) differ only by a
>> > single byte.
>> This is not the first laptop with an asus-like dsdt, some Lenovo are
>> supported by asus-laptop.
>> > Could this event be disabled somehow?
>> Don't know, can you send the result of acpidump ?
> I've attached the output of acpidump as well as the decompiled DSDT.

Looking at your dsdt:

BUF1 and BUF2 contains some easy to find data:

                        CreateByteField (BUF1, 0x01, EID1)
                        CreateByteField (BUF1, 0x02, ERQ0)
                        CreateByteField (BUF1, 0x03, BRIL)
                        CreateByteField (BUF1, 0x04, SKEY)
                        CreateByteField (BUF1, 0x08, BLUE)  bluetooth
                        CreateByteField (BUF1, 0x09, WLAN) wifi
                        CreateByteField (BUF1, 0x0A, WL3G) 3g
                        CreateByteField (BUF1, 0x0B, WMAX) wimax
                        CreateByteField (BUF1, 0x0C, GLSW)
                        CreateByteField (BUF1, 0x10, TPST) touchpad ?
                        CreateByteField (BUF1, 0x11, SLMD)
                        CreateByteField (BUF1, 0x12, SBR0) brightness ?
                        CreateByteField (BUF1, 0x13, SBR1)
                        CreateByteField (BUF1, 0x14, SBR2)
                        CreateByteField (BUF1, 0x15, SBBR)
                        CreateByteField (BUF1, 0x16, SBLI)
                        CreateByteField (BUF1, 0x17, TBMD)
                        CreateByteField (BUF1, 0x18, RTAG)

                        CreateByteField (BUF2, 0x01, EID2)
                        CreateByteField (BUF2, 0x08, BIV0)
                        CreateByteField (BUF2, 0x09, BIV1)
                        CreateByteField (BUF2, 0x0A, BIV2)
                        CreateByteField (BUF2, 0x0B, BIV3)
                        CreateByteField (BUF2, 0x0C, BIV4)
                        CreateByteField (BUF2, 0x0D, BIV5)
                        CreateByteField (BUF2, 0x0E, BIV6)
                        CreateByteField (BUF2, 0x0F, BIV7)
                        CreateByteField (BUF2, 0x10, WMIV)
                        CreateByteField (BUF2, 0x18, BRMX) brightness max ?
                        CreateByteField (BUF2, 0x20, BAT1) battery
                        CreateByteField (BUF2, 0x21, BAT2) battery
                        CreateByteField (BUF2, 0x22, ACDC) music ? :p
                        CreateByteField (BUF2, 0x23, CPUT) cpu temp ?
                        CreateByteField (BUF2, 0x24, VGAT)
                        CreateByteField (BUF2, 0x25, CDT1)
                        CreateByteField (BUF2, 0x26, CDT2)
                        CreateByteField (BUF2, 0x27, FSP1)
                        CreateByteField (BUF2, 0x28, FSP2)


Looking at _INI :
       Store (\_SB.BRNS, BRMX) probably means "set the brightness to
the maximum brightness"

WQIO returns both BUF1 and BUF2, you can get it with wmi_query_block()

WSIO calls CPSR and CPSR store the argument in INBF.
BY00, BY01, ... BY31, BGTX, BGTY, BGTZ etc ... are used to access
specific bytes in INBF :
                        CreateByteField (INBF, 0x00, BY00)
                        CreateByteField (INBF, 0x01, BY01)
                        CreateByteField (INBF, 0x02, BY02)
                        CreateByteField (INBF, 0x03, BY03)
                        CreateByteField (INBF, 0x04, BY04)
                        CreateByteField (INBF, 0x05, BY05)


CSPR wants BY00 to be 0x01 and BY01 to be 0x10 to do something.
It calls CMD0 (BY08, BY09, BY10, BY11, BY16)

ERQ0 (present in BUF1) is compared to Arg2 (BY09) == 0x1
if true, it will store some values and call notify
-- 
Corentin Chary
http://xf.iksaif.net
