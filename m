From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: ACPI + Laptop Power Management
Date: Fri, 28 Nov 2003 11:21:19 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA0338640F@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Micha Feigin [mailto:michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org]
> Sent: Friday, November 21, 2003 7:13 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] ACPI + Laptop Power Management
>=20
>=20
> On Fri, Nov 21, 2003 at 11:12:32AM +0100, Ducrot Bruno wrote:
> like said here, laptopmode is what you want since it holds back dirty
> buffer flushes which is what you are experiencing. It will fire up the
> disk on reads though. I attached a script that you can use to enter
> laptopmode (was actually distributed with laptopmode as far as I could
> tell when googling for the original patch). I call it in responce to
> ac events from acpid to get it running when the power is disconnected.
> Will have to make sure that you get those event though since I had to
> twik my dsdt for that.
> You can also look at cpufreq of acpi cpu throttling to=20
> throttle down you
> cpu when on battery to conserve power (assuming you cpu=20
> supports that).

I took a look at laptop mode. However, as the author said "it adds a
non-significant" amount of battery time.

The thing here is, even though it's flushing the buffers when there are
others to flush, it makes not difference if the drive is still spinning =
and
not in standby-mode! I can't figure out what is making the HD _not_ spin
down.

BTW, Laptop_mode is merged into the 2.4.23-rc5 kernel (based on the
changelogs)

With regard to ACPId events, can you tell me how yo get it to work? I'm
having problems getting it running. It gets lodaded up during init, and =
it's
running as root, but after logging in (GDM desktop), the events won't =
fire
until I kill the acpid process and re-run it again. (once I logged in)

I can't figure out how to get it to work. I read in one page where the
auther said to put xhost +local somewhere at the end of =
/etc/X11/xinitrc.
That didn't work either.

> I patched reiserfs to change the journal commit time=20
> according to the entry in
> bdflush so that I can get the regular 30 sec journal flush=20
> time when on
> ac and 10 minutes when of battery.
> I could try making such a patch for ext3 if you want.

You mean that has to be patched at the Kernel Code Level?? Ah.. Dang!


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
