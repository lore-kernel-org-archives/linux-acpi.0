From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: problem with cpu eating too much power, prize given if solved
Date: Thu, 01 Jul 2004 08:03:34 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opsafmf8px4evsfm@smtp.pacific.net.th>
References: <20040624153513.GB19545@rap.rap.dk> <20040628204008.GK698@openzaurus.ucw.cz> <opsadhbojo4evsfm@smtp.pacific.net.th> <20040629221111.GB25464@elf.ucw.cz> <opsaeu9tyb4evsfm@smtp.pacific.net.th> <20040630173754.GA29587@rap.rap.dk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040630173754.GA29587-EittdKFJ/bZ/SzgSGea1oA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Keld_J=F8rn_Simonsen?= <keld-6PR53cSIHaE@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 30 Jun 2004 19:37:54 +0200, Keld J=F8rn Simonsen <keld-6PR53cSIHaE@public.gmane.org> =
wrote:

> On Wed, Jun 30, 2004 at 10:16:31PM +0800, Michael Frank wrote:
>> On Wed, 30 Jun 2004 00:11:11 +0200, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
>>
>> >Hi!
>> >
>> >>>>Many times I just want to read the screen, eg emails or documents,
>> >>>>and then still the cpu will be in idle mode, where
>> >>>>it uses 7.5 W out of the about 15 W that the whole machine uses.
>> >>>>I have found out from Intel data sheets that my
>> >>>>Mobile Intel Celeron 2.0 GHz CPU consumes 7.5 W in idle loop/
>> >>>>stop grant/sleep states, (and 5.0 W i deep sleep state).
>> >>>>
>> >>>>So I would like to have the CPU stopped completely (consuming 0 W)
>> >>>>while I still could read the screen. In that way I should
>> >>>>be able to have about double the lifetime on the battery,
>> >>>>going to about 7 hours from the 3.5 hours I have now.
>> >>>>
>> >>>>I would like the machine to wake up again by any keystroke
>> >>>>on the keyboard or mouse input. I would like the input to be
>> >>>>reacted upon (not just used to wake up the system, and
>> >>>>then forgotten).
>> >>>>
>> >>>
>> >>>S1 is what you want... but... if you get what you asked for,
>> >>>do you realize that for example clock would not update on the deskt=
op
>> >>>in this mode?
>> >>
>> >>Which hardware can power down the CPU on its own?
>> >
>> >I thought that CPU powered down is pretty much definition S1.
>> >
>>
>> Please refer to http://acpi.sourceforge.net/documentation/sleep.html
>> and ACPI spec 2.0a around Page 216
>>
>> "Sleep States
>> 	S1 - "Stopgrant"
>> 	Power to cpu is maintained, but no instructions are executed.
>> 	The CPU halts itself and may shut down many of its internal
>> 	 components. In Microsoft Windows, the "Standby" command
>> 	is associated with this state by default.
>> "
>
> Well, I think what I want is S2, from the same document:
>
>      S2
>
>      While defined in the spec, this state is not currently in use. It
>      resembles S3 with the qualification that some devices are permitte=
d to
>      remain on.

"some devices" could include the CPU - fair enough!

>
>      S3 - "Suspend to RAM"
>
>      All power to the cpu is shut off, and the contents of its register=
s are
>      flushed to RAM, which remains on. In Microsoft Windows, the "Stand=
by"
>      command can be associated with this state if enabled in the BIOS.
>      Because it requires a high degree of coordination between the cpu,
>      chipset, devices, OS, BIOS, and OS device drivers, this system sta=
te is
>      the most prone to errors and instability.
>      Pavel Machek has created a small document with some hints how to s=
olve
>      problems with S3. You can find it in the kernel sources at
>      Documentation/power/tricks.txt.
>      S3 is currently _not_ supported by the 2.4.x kernel series in Linu=
x.
>
>
> I would like the CPU to power down, save things in memory, and then
> still have the screen and associated hardware on, and possibly also the
> keyboard and mouse if that is needed to capture an ACPI event, includin=
g
> the actual keystroke. This seems to be S2. I am not sure if all of S2
> needs to be implemented to do what I asked for, I just would like the
> functionality I described.
>
>> If you look at the original post, S1 "Stopgrant" costs 5W on his celer=
on.
>> It takes a lot
>> more on many 90nm chips. I read in the Centrino datasheet that it can =
draw
>> 15W
>> stopgrant at  _maximum_ vcore!!!. The maximum  possible power consumpt=
ion
>> is only 25W!.
>> Now, that is life with modern CMOS, leakage is most of the power
>> consumption....
>> I think it will improve but 1:3 is the best you can expect for multi G=
HZ
>> CPU's.
>
> According to that, then what I ask for could also be beneficial to
> centrino CPU's.

It would be benefitial to most CPU's also desktops.

>
>> So again, which (mainboard/notebook) HW does depower the CPU and keeps=
 the
>> rest running ?
>
> I thought this was something that most mainboards would support, given
> that we make the appropiate SW in the kernel.

If you want to depower the CPU, you have to depower its bridge
connections as well,  _No_  Mainboard especially the chipsets
can do that. . ... also need a seperate set of main regulators for the
CPU.

The software side would be mostly CPU part of S3.

>
> Another thing is that if a mainboard/BIOS supports ACPI, then it should
> actually support all of ACPI, including S2 support. Or am I wrong?

All optional by the spec. You get S0, and S5 and S4 and S3 when you
are  lucky. Got a P4 with S1 and S3, but its DSDT is so buggy I run
it with ACPI=3Doff and use swsusp 2 on 2.4.

>
>> As to ACPI there should be a S2.5 state, or a S3 extension to power do=
wn
>> the CPU and run the rest...
>
> I thought S2 was actually powering down the cpu, saving all registers
> and things in memory, like S3, and then leaving some devices on. As I h=
ave read it,
> this is clean S2, and not a 2.5 level. But I am not an ACPI expert.

It could be, provided someone writes a spec on how to power the CPU down
while keeping the rest running and the manufacturers implement it.

ACPI  for Linux implements the spec and supports features supported
by hardware. I suggest you discuss in a PC hardware forum.

	Best Regards
	Michael


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
