From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Tue, 2 Mar 2004 11:33:37 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C6E94@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Nick Lidakis [mailto:nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org]
> Sent: Tuesday, March 02, 2004 11:18 AM
>=20
> Ow Mun Heng wrote:
>=20
> Ok, it seems to work with a 2.6.3 kernel; highmem and=20
> preemtion disabled.
> Can I ask you how you have USB enabled? Compiled into the=20
> kernel or as=20
> modules?
> I could have sworn I erad something about ACPI swsusp and USB=20
> conflicts.
>=20
> Do you use swsusp constantly, and do you find reliable so far?


Hmm.. Sorry.. I just reread your subject line.. It=20
says.. S3 suspend.I've not been able to get that to work.=20
(Still have not experimented a lot) and Yes.. you heard
right.

Currently Have got S4 to work.. Suspend to disk. I think it's also=20
swsusp. (or swap suspend)

Refer to my thread "success: S4 on D600" or somethinglike that.

USB/eth is modules. rmmod the eth mod before S4'ing.
S3/S1 hangs on resume. Hangs as in Console/X/graphics.

I suspend only a few times.. Just got it working like On Sunday.
and today's Tuesday.. :)


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
