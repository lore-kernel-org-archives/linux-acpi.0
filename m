From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI S3 resume only reboots
Date: Sat, 9 Oct 2004 23:52:43 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8405BD1226@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Alberto <albeclemit-whZMOeQn8C0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 Normal reboot? Did you see the normal shutdown message from screen?

If so, please try to kill acpid or any other userland daemo.=20
Because, some box will generate a power button event if you press power
button to wake up machine.

If not, you need to narrow down the problem.

Thanks,
Luming

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Pavel Machek
>Sent: Saturday, October 09, 2004 9:06 PM
>To: Alberto
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] ACPI S3 resume only reboots
>
>Hi!
>
>> I'm using kernel 2.6.9-rc3-bk2 + latest acpi + swsusp2
>>=20
>> When i do
>> cat -n "mem" > /sys/power/state
>> the system seems to go down fine in S3 state...
>> when i hit the power button it looks like trying to resume=20
>(fan starts again, noises from harddisk and cdrom) then it=20
>just reboots....
>>=20
>> # lspci
>> 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377=20
>[KT400/KT600 AGP] Host Bridge (rev 80)
>> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
>> 0000:00:09.0 FireWire (IEEE 1394): VIA Technologies, Inc.=20
>IEEE 1394 Host Controller (rev 80)
>> 0000:00:0b.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus=20
>Controller (rev 20)
>> 0000:00:10.0 USB Controller: VIA Technologies, Inc.=20
>VT82xxxxx UHCI USB 1.1 Controller (rev 80)
>> 0000:00:10.1 USB Controller: VIA Technologies, Inc.=20
>VT82xxxxx UHCI USB 1.1 Controller (rev 80)
>> 0000:00:10.2 USB Controller: VIA Technologies, Inc.=20
>VT82xxxxx UHCI USB 1.1 Controller (rev 80)
>> 0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
>> 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
>> 0000:00:11.1 IDE interface: VIA Technologies, Inc.=20
>VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
>> 0000:00:11.5 Multimedia audio controller: VIA Technologies,=20
>Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
>> 0000:00:11.6 Communication controller: VIA Technologies,=20
>Inc. Intel 537 [AC97 Modem] (rev 80)
>> 0000:00:12.0 Ethernet controller: VIA Technologies, Inc.=20
>VT6102 [Rhine-II] (rev 74)
>> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc=20
>Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01)
>>=20
>> I removed all the modules and tryed from runlevel 1, all the=20
>usb devices where unplugged as well...
>>=20
>> I googled about it and i found other people with the same=20
>KT400/KT600 chipset reporting the same problem.
>>=20
>> How could i try to debug this to give you more info?
>
>You basically need to fix this yourself. Add infinite loops to
>wakeup.S to see where it breaks.
>								Pavel
>--=20
>People were complaining that M$ turns users into beta-testers...
>...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: IT Product Guide on=20
>ITManagersJournal
>Use IT products in your business? Tell us what you think of=20
>them. Give us
>Your Opinions, Get Free ThinkGeek Gift Certificates! Click to=20
>find out more
>http://productguide.itmanagersjournal.com/guidepromo.tmpl
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
