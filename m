From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: New Smart Battery release (incl. updated embedded controller patches)
Date: Tue, 20 Dec 2005 15:27:34 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840A7607EB@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Lebedev, Vladimir P" <vladimir.p.lebedev-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 I just replace spin_lock_irq_xx with mutex for poll code path of ec =
driver.
It is at http://bugzilla.kernel.org/show_bug.cgi?id=3D5764 .

For issues observerd on Smart Battery driver with ec_intr=3D1 (aka =
"ec_burst=3D1")
 , we need to follow up. =20

Please try to kill acpi daemon to see if your problem get resolved?

Thanks,
Luming


>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Lebedev, Vladimir P
>Sent: 2005=C4=EA11=D4=C216=C8=D5 1:39
>To: Rich Townsend; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Cc: Brown, Len; Starikovskiy, Alexey Y
>Subject: RE: [ACPI] New Smart Battery release (incl. updated=20
>embedded controller patches)
>
>Hi Rich,
>
>I am attaching patch for kernel 2.6.14 with SBS drivers based=20
>on drivers
>which were written by you and Bruno Ducrot.
>
>Also this patch contains your latest updates of embedded controller
>(ec.c file)
>
>Differences to your version include some cleanup, handling of battery
>removal/insertion, and non-conflicting operation with ACPI battery and
>ac modules.=20
>
>All work pretty good on Acer TravelMate 2303LCi.
>
>If you are interested, apply the patch, set ACPI_SBS configuration
>variable (Smart Battery System - bottom of menu) to 'y' or 'm'(modprobe
>acpi_sbs will be required in case 'm'), etc. Module acpi_sbs depends on
>ACPI_AC, ACPI_BATTERY and I2C.
>
>Vladimir.
>
>
>
>=20
>
>=20
>
>=20
>
>=20
>
>
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Rich
>Townsend
>Sent: Sunday, November 13, 2005 7:14 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] New Smart Battery release (incl. updated embedded
>controller patches)
>
>
>I'm pleased to announce that, after quite a long period of inactivity,
>I've=20
>finally managed to grab enough spare time from the real world to bring
>the=20
>SBS-CM (Smart Battery System/Control Method) project up to date.
>
>Those relying on this project to check their battery status (primarily
>on Acer=20
>laptops) can now grab the sbs-cm-20051112 release of SBS-CM from the
>Sourceforge=20
>download page:
>
>https://sourceforge.net/project/showfiles.php?group_id=3D129330
>
>In this new release, I haven't made any changes to the DSDT stuff.
>However, I've=20
>included new patches for replacing the spinlock mutexing in=20
>the embedded
>
>controller (EC) driver with semaphore mutexing. In addition to the
>kernel 2.6.10=20
>and 2.6.11 patches included in previous releases, I now provide patches
>for=20
>2.6.12. 2.6.13 and 2.6.14 kernels. I intend to offer a 2.6.15=20
>patch once
>this=20
>kernel version becomes the current version.
>
>Why are these patches still necessary? Yuming Lu has done some great
>work=20
>getting EC burst mode working under Linux; I believe all kernels since
>2.6.13=20
>contain the burst mode code by default. Unfortunately, however, burst
>mode does=20
>not fix the problems that the spinlock patches were designed to fix.
>
>To be specific: I have fixed my kernel (2.6.13) with Yuming's most
>recent patch=20
>that prevents the boot process from stalling when the EC driver is
>loaded.=20
>Booting with burst mode enabled (boot parameter ec_burst=3D1) gets into
>immediate=20
>trouble if I have the thermal zone ACPI driver loaded, since=20
>my computer
>thinks=20
>the cpu is at 250C. This is indicative that the EC is not working
>properly.
>
>Then, after disabling the thermal zone stuff, my computer boots up OK
>but still=20
>shows all the symptoms of lost interrupts. Furthermore, after=20
>10 minutes
>of=20
>uptime, I notice that the kacpid task has expended nearly 3 seconds of
>CPU time.=20
>This expenditure is wholly due to the EC access, and indicates that for
>3=20
>seconds out of 10 minutes, the EC burst code is not interruptible --
>hence the=20
>lost interrupts.
>
>While I will certainly agree that my own patches are not nearly as
>elegant as=20
>the burst mode solution, I must point out that they do not lead to any
>lost=20
>interrupts at all -- I don't lose any keypresses, and the kacpid task
>doesn't=20
>use up any CPU time.
>
>I would really appreciate it if those involved in maintaining the EC
>code ---=20
>both Yuming and perhaps Len Brown --- could get in touch with me and
>help sort=20
>out a way to get EC burst mode working without lost interrupts. When
>that's=20
>done, I'll feel much more comfortable about focusing on porting my SBS
>stuff to=20
>the HAL, which is where it belongs.
>
>Best wishes,
>
>Rich T
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by:
>Tame your development challenges with Apache's Geronimo App Server.
>Download
>it for free - -and be entered to win a 42" plasma tv or your very own
>Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
