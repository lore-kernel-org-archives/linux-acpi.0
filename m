From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: thermal zone causing insta-reboot on bootup of 2.6.3
Date: 11 Mar 2004 02:01:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078988500.2554.89.camel@dhcppc4>
References: <002c01c40701$11116190$7ce9fea9@SHERKA>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <002c01c40701$11116190$7ce9fea9-UdiLdEXzXlE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Ois=EDn?= Mac =?ISO-8859-1?Q?Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

if you delete the thermal module, this failure will go away
(and so will our ability to debug it;-)

perhaps you can file a bug at bugzilla.kernel.org
category: ACPI
component: Power-Thermal

and attach the output from dmesg -s40000 with thermal installed.

clearly we're getting a bogus temperature reading.

thanks,
-Len

On Wed, 2004-03-10 at 19:37, Ois=EDn Mac Fheara=ED wrote:
> After installing the 2.6.3 kernel on Mandrake 9.2 on an Acer Aspire
> 1705SMi laptop, my machine repeatedly prints "Critical temperature
> reached (255 C), shutting down." and reboots.
> Installing the 20040220 patch to it seems to have made no difference
> (and added no options that I could see to "make menuconfig" - in fact
> it removed the options for relaxed something under the ACPI options
> page, which wasn't doing anything anyway)...
> =20
> Can anyone advise? I'm quite inexperienced with linux, so I might be
> doing something stupid (also, I'm having trouble finding which boot
> messages are kept in which logfiles...).
> I'm too scared by the "might damage your CPU" message to remove
> thermal zone from the kernel ACPI settings.
> =20
> Ois=EDn



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
