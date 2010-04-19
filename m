From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Mon, 19 Apr 2010 17:46:21 +0200
Message-ID: <p2r71cd59b01004190846m29f82672w93966b499aa917cf@mail.gmail.com>
References: <1271518653.4549.186.camel@flunder>
	 <q2s71cd59b01004181221kce7c1e5cn7742b1063827ac3b@mail.gmail.com>
	 <1271687130.26267.147.camel@pancake>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1271687130.26267.147.camel@pancake>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 19, 2010 at 4:25 PM, Florian Echtler <floe@butterbrot.org> wrote:
> Am Sonntag, den 18.04.2010, 21:21 +0200 schrieb Corentin Chary:
>> On Sat, Apr 17, 2010 at 5:37 PM, Florian Echtler <floe@butterbrot.org> wrote:
>> > I've just bought an Ideapad S10-3t, and most features including ACPI
>> > work fine. However, since neither thinkpad-acpi nor lenovo-sl-laptop
>> > support this device, I've been looking around for some hints on how to
>> > access the embedded controller in order to get the hotkeys working. I'll
>> > post what I've found so far and hope that somebody could give me some
>> > hints as to how to proceed.
>> > First, I've dumped the DSDT and browsed through it. I've found a _WDT
>> > section, and wmidump shows:
>> Wow, someone actually used that tool ^^
>> A Quick hint would be to look at
>> https://patchwork.kernel.org/patch/87210/ which is basically a really
>> short example of what a wmi-driver is.
>> Just change the guid, buid/load, push some hotkeys, see dmesg, edit
>> the keymap, build, load, test ..
> Thanks for the pointer - I've given it a quick try and the driver loads
> successfully, however, the event doesn't seem to be triggered. I've put
> a printk into the eeepc_wmi_notify function, and this is seemingly never
> called.. although I believe this may be the right direction, as the GUID
> from the eeepc driver (ABBC0F72-8EA1-11D1-00A0-C90629100000) and the one
> from my Lenovo (ABBC0F20-8EA1-11D1-00A0-C90629100000) differ only by a
> single byte.

This is not the first laptop with an asus-like dsdt, some Lenovo are
supported by asus-laptop.

> Could this event be disabled somehow?

Don't know, can you send the result of acpidump ?

> Corresponding to the 2nd GUID, there's also a WQIO method in my DSDT
> which should return a data block, correct?

Yes, and WCIO methods too.
Check the code of wmi_query_block in wmi.c and grep it in
drivers/platform/x86/ to see how to use it.

See: http://www.microsoft.com/whdc/system/pnppwr/wmi/wmi-acpi.mspx


-- 
Corentin Chary
http://xf.iksaif.net
