From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Resume with Samsung X10
Date: Fri, 16 Jul 2004 09:24:18 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F03568273@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Hesse <mail-8oMOrB1mGocUSW6y5lq3GQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
Please try latest ACPI bk tree, we have bunch of update about
sleep/wakeup. And if it still can't work, please send the 'acpidmp'
output.

Thanks,
Shaohua
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Christian Hesse
>Sent: Thursday, July 15, 2004 10:25 PM
>To: Dominik Brodowski; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Resume with Samsung X10
>
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>On Thursday 15 July 2004 15:12, Dominik Brodowski wrote:
>> On Thu, Jul 15, 2004 at 01:58:43PM +0200, Christian Hesse wrote:
>> > Hello!
>> >
>> > For some time I'm trying to get Suspend to RAM to work on my
Samsung
>X10
>> > now. It suspends without problems, the power led is blinking in
suspend
>> > mode. But there is no way to wake the device. I have to unplug the
AC
>and
>> > take out the battery, after that I can boot normally.
>> >
>> > I searched for similar problems in the existing bugreports on the
acpi
>> > website. Some people reported the same problem, but nobody found a
>> > solution till now I think. The patch from bug 1415 didn't help me.
>>
>> What does
>> cat /proc/acpi/wakeup_devices
>> tell you after applying these two patches? Did you enable one/all
>> wakeup devices in this file?
>
># cat /proc/acpi/wakeup_devices
>Device  Speep state     Status
>LID0       3            disabled
>PWRB       4            disabled
>LANC       4            disabled
>MODM       4            disabled
>
>I enabled all theses entries, but nothing changed.
>
>One thing I just noticed: Pressing the power button (no matter whether
>enabled
>in wakeup_devices or not) does not generate any events in
/proc/acpi/event.
>Pressing Fn+Esc dos ("button/sleep SLPB 00000080 00000002") but this
button
>ist not listed in /proc/acpi/wakeup_devices. BTW, what exactly are LANC
and
>MODM?
>
>Christian
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.4 (GNU/Linux)
>
>iD8DBQFA9pPIlZfG2c8gdSURAo+RAJ43SxWt9DdgPUr6xUIRkkbHH5lhpgCgi3U/
>dSqwUm/QY6eBrB0h8ozvzi8=3D
>=3DDoYu
>-----END PGP SIGNATURE-----
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by BEA Weblogic Workshop
>FREE Java Enterprise J2EE developer tools!
>Get your free copy of BEA WebLogic Workshop 8.1 today.
>http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=3Dick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
