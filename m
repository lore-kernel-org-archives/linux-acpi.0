From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>
Subject: Re: eisa_set_level_irq(acpi_fadt.sci_int)
Date: 24 Oct 2003 21:03:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1067025802.1563.5.camel@darkstar.portugal>
References: <1066254483.2535.51.camel@dhcppc4>
	<20031017154107.GI8668@poupinou.org>  <1066411716.2527.100.camel@dhcppc4>
	<1066796711.2593.30.camel@dhcppc4>
	<1066964092.1541.16.camel@darkstar.portugal>
	<1066965206.3864.55.camel@dhcppc4>
	<1066969171.1608.32.camel@darkstar.portugal>
	<1066975669.3861.84.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1066975669.3861.84.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Ok works well with vanilla -pre7=20
so the problem is not in this patch.

cat /proc/interrupts
           CPU0
  0:      19650          XT-PIC  timer
  1:        402          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci
 10:         15          XT-PIC  acpi
 11:         18          XT-PIC  eth0
 12:       1188          XT-PIC  PS/2 Mouse
 14:       9982          XT-PIC  ide0
 15:       1526          XT-PIC  ide1
NMI:          0
ERR:          0


On Fri, 2003-10-24 at 07:07, Len Brown wrote:
> Are you running with the kacpid patch to poll for acpi events
> as mentioned in the link below, or vanilla -pre7 and -pre8?
>=20
> Does /proc/interrupts for vanilla -pre8 show any acpi interrupts
> after acpi events?
>=20
> Does /proc/interrupts for vanilla -pre7 show any acpi interrupts
> after acpi events?
>=20
> Please apply this patch to your -pre7 tree and tell me if you see any
> changes in behaviour:
>=20
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.4.=
22/20031020180809-eisa_set_level_irq.patch
>=20
> again showing /proc/interrupts after acpi events.
>=20
> My expectation is that it should make no difference, except
> for printing the extra line about changing the trigger mode.
>=20
> If the kacpid patch is necessary for you to get any acpi events,
> then the real bug here is how to get the VT82C686 to deliver
> acpi events without resorting to polling.

Was necessary until ACPI-20020907, not any more ok !

>=20
> thanks,
> -Len
>=20
>=20
--=20
S=E9rgio Basto




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
