From: Brouard Nicolas <nicolas.brouard-TDf4sKD1mxeHlu7OokbhRg@public.gmane.org>
Subject: Re: Sonypi resuming nicely. Was "ACPI S4 suspend resuming
	instead of powering off"
Date: Sun, 07 Nov 2004 21:26:27 +0100
Message-ID: <1099859187.2828.50.camel@localhost>
References: <1099593139.6265.17.camel@pichat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1099593139.6265.17.camel@pichat>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Le jeudi 04 novembre 2004 =E0 19:32 +0100, Brouard Nicolas a =E9crit :
> Hi,
>=20
> I have been using echo 4>/proc/acpi/sleep on kernel 2.6.8.1 successfull=
y
> since some time now on my Sony Z1.=20
>=20
> The sonypi module has been patched recently (Dmitry Torokhov) and
> Stelian Pop) in order to suspend/resume correctly. I have been able to
> patch a kernel 2.6.8.1 with these patches (need kfifo and
> roundup_pow_of_two patches from 2.6.10).=20
>=20
> And suspending/resuming works well but it doesn't halt in between! It i=
s
> only cycling.
>=20
> In fact I discovered that the reason is elsewhere. Just at the same tim=
e
> I upgraded my system (Mandrake cooker uptodated 10.1) by using the 6 CD
> of the Mandrake 10.1 Official distribution. The upgrade was very quick
> because all of my rpms were already updated, but the upgrade added new
> services (Bluetooth) and modules and even other configuration which I
> don't know.
>=20
> I had a list of former modules and removed the new modules (or
> daemon/services) added by the upgrade. But I am STILL cycling and don't
> know what to do.
>=20
> With all of my tests or official kernel I am recycling.
>=20
> Is there a parameter in /proc/acpi/??? which makes the cycling.
>=20
> Any hint will be appreciated.


During the installation of Mandrake 10.1 Official, via the CD,
my /etc/lilo.conf has been changed and specifically the name of the swap =
partition.
If I set it back to the original partition name, it is suspending, haltin=
g and
resuming well.

It was formerly: swap=3D/dev/hda8 but it has been changed to
  swap=3D/dev/brouvg/swaplv=20
which was a former swap partition within my "volume group" (LVM) and it i=
s
not a good idea to have a logical volume for a swap.=20

With this new sonypi module resuming nicely, ACPI/S4 is working
satisfactorily on my Sony Z1. Until this summer, it wasn't possible to
hope suspending to disk with S4, and there was more hope with swsusp2.
But since 2.6.8 and the inclusion of all your patches during the summer,
I am using S4 again. Evdev and psmouse which I need for my Alps touchpad
do not need to be unloaded before resuming with swsusp1 (it is still
required for swsusp2 I think).=20

Thus, my suspend script concerns mostly the clock and usb modules only.
I am able to suspend from a replicator at work and to resume correctly
at home with another network (if I add eth0 to be restarted after
resuming).

Depending on the load, I am able to suspend in about 1 minute (up to
complete power off) and to resume in about the same amount of time.

By using this new sonypi module my gain is about 5 to 10 seconds (not
because of the module itself but because of the service sonyxosd which
needed some time to be reloaded). It is not a huge gain, but step by
step it is shortening the delay of suspending/resuming.

Thanks a lot to all the people who contributed to make
resuming/suspending working.=20

Yes, suspend to RAM is not here for a Sony but it might come...

Cheers,

Nicolas Brouard


PS: If people are interested in running the new sonypi modules, Stelian
Pop/Dmitry Torokhov patches are already filed in 2.6.10.xx, but if you
need to use the 8 patches against a standard kernel like Mandrake 10.1
official (2.6.8.1) you need two additional patches, one for kfifo and
another for a macro "roundup_pow_of_two"; and you can find them at
http://sauvy.ined.fr/~brouard/sony/patches .

=20
--=20
Brouard Nicolas <nicolas.brouard-TDf4sKD1mxeHlu7OokbhRg@public.gmane.org>



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
