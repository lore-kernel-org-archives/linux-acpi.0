From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Acer TM 661 does not wake up from STR
Date: Wed, 25 Aug 2004 10:12:39 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <412CC887.9080706@root.org>
References: <412CA779.8000602@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <412CA779.8000602-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mirko Werneke <mirko.werneke-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Mirko Werneke wrote:
> I've a really big problem with my Acer Travelmate 661 laptop: Once=20
> suspended to ram, it won't wake up again! The laptop seems to suspend=20
> corretly (no error messages while suspending; Power LED switches from=20
> green to orange). But after a key press to wake it up the only reaction=
=20
> the laptop shows is switching the power led to green again. Nothing mor=
e=20
> happens. I've to press the power button for 4 seconds to switch the=20
> laptop completely off. After that i can reboot normally.
>=20
> Besides from playing around withh several parameters ("noapic",=20
> "pci=3Drouteirq", "acpi_sleep=3Ds3_bios"/"s3_mode") i tried with help f=
rom=20
> Stefan D=F6singer the following:
>=20
> I compiled a minimal kernel (without usb/wlan drivers, etc.) with a=20
> little patch in wakeup.S.
> I inserted after .code16 the line "lcall $0xffff,$0". This should -=20
> according to Stefan - immediatly call the BIOS reset code after the=20
> kernel gets control back from BIOS. But the situation did not change (n=
o=20
> "automatic" reboot after resume). So we came to the conclusion, that th=
e=20
> kernel does not get the control back when the system wakes up.
> So i think that there is a problem with the BIOS or the kernel does=20
> something wrong while suspending.

So the BIOS is not calling the wake vector.  I've been wondering about=20
several deviations from the spec in the sleep path (hwsleep.c).

I think _GTS should be run immediately before writing the sleep value in=20
EnterSleepState (not Prep).  Section 7.3.3:  "OSPM will set the sleep=20
enable (SLP_EN) bit in the PM1 control register immediately following=20
the execution of the _GTS control method without performing any other=20
physical I/O or allowing any interrupt servicing."

I'm suspicious of writing the SLP_TYP and SLP_EN on separate passes.=20
The sample code in the spec (7.3.4) writes this in one pass.  If there=20
are systems that require multi-pass write, we should leave this as an=20
option, disabled by default, since I think most systems do this correctly.

We should check the return value of \_WAK and at least print the result=20
code if non-zero. (7.3.5)

One non-standard thing is that I think LeaveSleepState should read=20
values from \\_S0 and if this method is present, write those to slp reg=20
A/B in the resume path.

--=20
Nate


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
