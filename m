From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC] dev_acpi: support for userspace access to acpi
Date: Thu, 28 Oct 2004 01:17:36 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFF8@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

  If don't use acpi_early_init , acpi is initialized in do_basic_setup() =
in kernel thread --init.
It is very close to launch first user space process(/sbin/init ..). So, =
if we can invent=20
acpi_later_init, it is possible to move interpreter out of kernel.

  The difficulty for inventing userspace interpreter is to eliminate the =
ACPI-interpreter dependency=20
of drivers for booting. But this dependency is not mandatory. Once =
kernel booted to be able
to launch /sbin/init, it is also able to launch =
/sbin/user_space_interpreter, then kernel can enjoy
acpi from then on, despite the acpi interpreter is a user space daemon, =
we just need to invent
or user a communication method between kernel and user space daemon.

  But, Not sure what's the evil consequence from this approach. Say, if =
kernel need service
from ACPI interpreter, ACPI interpreter should be get scheduled.  Is it =
racy?

Thanks
Luming=20

>-----Original Message-----
>From: Alex Williamson [mailto:alex.williamson-VXdhtT5mjnY@public.gmane.org]=20
>Sent: 2004=C4=EA10=D4=C227=C8=D5 11:27
>To: Yu, Luming
>Cc: linux-kernel; acpi-devel
>Subject: RE: [ACPI] [RFC] dev_acpi: support for userspace=20
>access to acpi
>
>
>   The kernel certainly needs an ACPI interpreter and it needs=20
>it before
>userspace is launched.  Handing off the interpreter to userspace or
>managing two interpreters poking ACPI at the same time seems=20
>like a much
>more complicated problem.  The kernel is the primary consumer, I think
>it would just shift the problem elsewhere to consider moving it.
>
>  The problems quoted below were from the previous sysfs=20
>interface I was
>developing.  I think these problems are fixed with this current device
>file interface.  I'm hoping dev_acpi is already more clean.  Thanks,
>
>	Alex
>
>On Wed, 2004-10-27 at 10:30 +0800, Yu, Luming wrote:
>> If you want to have a full access to acpi subsystem from userspace,
>> why not firstly move ACPI interpreter out of kernel?
>> Then, you can play with the whole ACPI subsystem with minimal cost of
>> troubling kernel  in userspace.  Say, you can forget "=20
>> ioctl, read issues on files, complex data for sysfs, file per
>> operation, etc...".  Is it a more clean way ?
>> =20
>> Thanks
>> Luming=20
>>=20
>> >-----Original Message-----
>> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>> >[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>> >Alex Williamson
>> >Sent: 2004=C4=EA10=D4=C227=C8=D5 4:55
>> >To: linux-kernel
>> >Cc: acpi-devel
>> >Subject: [ACPI] [RFC] dev_acpi: support for userspace access to acpi
>> >
>> >
>> >   Announcing the next revision of dev_acpi.  The dev_acpi module
>> >provides userspace access to ACPI namespace using a simple character
>> >device file.  For further discussion of the interface, see=20
>the README
>> >file in the tarball.  The current release is available here:
>> >
>> >http://free.linux.hp.com/~awilliam/acpi/dev_acpi/dev_acpi-20041
>> >026.tar.bz2
>> >
>> >(it's a little big to post here raw, but if requested I'd=20
>be happy to
>> >post the driver by itself)
>> >
>> >   I've been tossing around sysfs and device file interfaces=20
>> >to the ACPI
>> >namespace for a while now.  The idea is that there's way too much
>> >information in namespace to not provide a userspace interface to it.
>> >Examples include projects springing up to support ACPI features on
>> >various laptops, increasing dependence on developing code=20
>using ACPI,
>> >extracting system/platform information from ACPI namespace.=20
> In short,
>> >there are a lot of really simple things that userspace=20
>could use ACPI
>> >namespace for, but there's currently no way to get to it.
>> >
>> >   Previous iterations using sysfs looked pretty, but never really
>> >achieved the full potential of the interface (no ioctl,=20
>read issues on
>> >files, complex data for sysfs, file per operation, etc...).=20
> The device
>> >file interface provides a more comprehensive yet compact interface,
>> >along with a 32bit compatibility layer, and sane read=20
>semantics on the
>> >file.
>> >
>> >   This revision cleans up quite a bit of code, adds some=20
>documentation
>> >in the README file, adds a number of interfaces, and adds=20
>several more
>> >example program, with the intent of sparking more interest.  I've
>> >updated the acpitree program to list a bit more data, but it's=20
>> >basically
>> >the same.  For anyone trying to wrap their head around ACPI=20
>namespace,
>> >it's a great tool for getting a simple visual representation=20
>> >of the data
>> >available.  I added a tool called acpivideo that will hopefully be
>> >interesting to laptop users.  It's able to set the active=20
>video output
>> >device, much like the hotkey on most laptops (but from=20
>command line).
>> >It also has a daemon mode that sets up a notify handler (yes, from
>> >userspace) and listens for events on the VGA device.  When=20
>an event is
>> >received, it evaluates the requested state change and pokes=20
>ACPI to do
>> >it.  See the README for more info.  If anyone knows how to=20
>> >poke X to not
>> >block the switch it'd be interesting to add the hooks=20
>(currently only
>> >seems to work from a vt).
>> >
>> >   I added another simple program called acpiundock.  If you have a
>> >laptop docking station with an electo-mechanical eject (like the
>> >omnibook 500), this one should be fun.  There are no option,=20
>> >just run it
>> >and see what happens (please be prepared for it to work... it just
>> >might).
>> >
>> >   Another fun developer tool/hack is eventwatch.  This program is
>> >simply a version of acpitree that tries to install notify=20
>handlers on
>> >every device in namespace.  It then sits and waits for something to
>> >happen.  If you've wondered if that hotkey on your box does=20
>something,
>> >try this, it just might.
>> >
>> >   I skimmed though the ibm-acpi module and tried to provide enough
>> >interfaces in this version of dev_acpi that the entire=20
>ibm-acpi could
>> >potentially be done in userspace.  I don't have an IBM laptop to
>> >experiment with, but I'd be interested to hear if someone tries.
>> >
>> >   Anyway, please give this interface a shot.  It builds as a=20
>> >standalone
>> >module and should work on any 2.6 kernel with headers=20
>available.  I've
>> >tested this version quite a bit more than the version I=20
>posted a couple
>> >weeks ago, especially the 32bit app on 64bit kernel code (ia64 and
>> >x86_64).  Bug reports, feedback, opinions gladly welcomed.  Thanks,
>> >
>> >	Alex
>> >
>> >--=20
>> >Alex Williamson                             HP Linux & Open=20
>Source Lab
>> >
>> >
>> >
>> >-------------------------------------------------------
>> >This SF.Net email is sponsored by:
>> >Sybase ASE Linux Express Edition - download now for FREE
>> >LinuxWorld Reader's Choice Award Winner for best database on Linux.
>> >http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
>> >_______________________________________________
>> >Acpi-devel mailing list
>> >Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> >https://lists.sourceforge.net/lists/listinfo/acpi-devel
>> >
>>=20
>--=20
>Alex Williamson                             HP Linux & Open Source Lab
>
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
