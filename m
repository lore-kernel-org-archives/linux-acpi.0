From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: SMP, "noapic", usb, interrupts : problem solved !
Date: Sun, 30 Nov 2003 00:28:12 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC887E@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Janek Kozicki <janek_listy-5tc4TXWwyLM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Janek,
Thanks for the feedback.

I suspect that ACPI is not running on this system because:
1. 4xP3 600Mhz is probably < 2001 default ACPI cutoff date.
2. changing MPS 1.4 -> 1.1 made a difference.

Feel free to drop the info you've collected into a bug report and I can
take a closer look.
Note that if ACPI is disabled by default, "acpi=3Dforce" on the cmdline
would enable it.

Thanks,
-Len

How to file a bug against ACPI:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach the output from dmidecode, available in /usr/sbin/, or
here:=20
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Janek Kozicki
> Sent: Saturday, November 29, 2003 1:44 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] SMP, "noapic", usb, interrupts : problem solved !
>=20
>=20
> hello,=20
>=20
> I'm using SMP (Abit VP6, 2 x PIII 600MHz) motherboard.
>=20
> I've been using for a long time 2.4.19 kernel, and everything was
> working good. 2.4.18 also was working good.
>=20
> Once I tried to upgrade to 2.4.20 but usb mouse stopped working, so=20
> I went back to 2.4.19. Next time, when 2.4.21 was released I tried=20
> new kernel, but once again usb mouse was not working in the new=20
> kernel. Needless to say that 2.4.22 and 22.4.23 are also broken.
>=20
> Two weeks ago I upgraded from debian/woody to debian/sarge, and I
> discovered that kernels older than 2.4.21-pre5 do not compile in
> debian/sarge (problem with gcc 3). So I decided that this time I MUST
> get a working kernel.
>=20
> I was fighting for two weeks with this problem, each day compiling new
> kernel two or three times. I tried everything possible configuration,
> every possible patches, I was even hacking kernel myself (but very
> little ;)). I was also searching google for the solution while waiting
> for new kernel to compile.
>=20
> One of these patches was from acpi-devel but that also didn't help.
>=20
> I've read somehere that passing an option "noapic" to the=20
> kernel solves
> that problem. Indeed usb started working. But another problem occured:
> second CPU stopped handling interrups. Too bad I thought.
>=20
> But "noapic" is closely related to acpi-devel subject so I=20
> subscribed to
> this group to post a question here: "what to do?".
>=20
> Suddenly, today, while searching google once again I've found=20
> a solution
> (on the kernel-devel forum of *BSD* users (!)).
>=20
> I had to switch handling SMP in BIOS from MPS 1.4 to older=20
> one MPS 1.1.
> And now, when my motherboard uses MPS 1.1 I don't need=20
> "noapic" option,
> and usb works, and both CPUs handle interrupts correctly.=20
> Moreover even
> my usb digital camera, and usb cellular phone (nokia 5510) are working
> correctly as external usb-scsi hard drives.
>=20
> So instead of posting "what-to-do?" post, I would rather post=20
> "hey I've
> found a solution" so everyone elese using google can find it and solve
> this strange problem.
>=20
>=20
>=20
> On the other hand: what is wrong with kernels older than 2.4.19=20
> (2.4.20 to 23) that they stopped handling correctly MPS 1.4 ?
>=20
> I think it's a bug, and I think that this bug is related to acpi-devel
> since "noapic" option _partly_ solves that problem.
>=20
> In case anyone wants my help with solving this bug I can provide: The
> output from dmesg -s40000, The output from dmidecode, The output from
> acpidmp, the output from lspci -vv and cat /proc/interrupts.=20
> I will also
> help in checking patches, or whatever else you may need.
>=20
> my current kernel configuration (the one that works):=20
> - acpi in kernel disabled (enabling it didn't help at all)=20
> - kernel boot options: "hdd=3Dide-scsi hdc=3Dide-scsi " (because I =
have=20
>   a CD writer),=20
> - NO "noapic" kernel boot option.=20
> - kernel 2.4.23 unpatched (directly from kernel.org)=20
> - motherboard set MPS to 1.1=20
> - /dev/hiddev in kernel config disabled (when enabled - usb didn't=20
>   work, but I haven't checked how about MPS 1.1 + /dev/hiddev. If=20
>   you want me to check please let me know)=20
> - both UHCI compiled as modules, so that program hotplug (on debian=20
>   apt-get install hotplug) can select whichever it prefers.=20
> - usb mouse compiled into kernel=20
> - hotplug enabled=20
> - make sure graphic card has non-shared IRQ 9 or 10 or 11=20
> (this is _not_
>   related to usb I think. It's rather related to "noapic" since bad
>   hadling of irqs (only one kernel) caused graphic card to=20
> misbehave (GLX
>   stops working after some peroid of time) I just had problems with my
>   just-bought matrox graphic card. and here is the "I-hope" solution)=20
>=20
>=20
>=20
> In case you feel this MPS 1.4 bug is not related to acpi-devel please
> let me know and point somewhere else where I can offer my help and
> willingness to solve this problem.
>=20
> I'm unfortunately not a kernel hacker (hacking a little=20
> doesn't mean I'm
> a hacker ;)), and I hadn't report this bug anywhere else. If you know
> where it should be reported I will gladly do it.
>=20
>=20
> --=20
> # Janek Kozicki
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
