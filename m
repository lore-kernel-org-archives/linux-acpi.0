From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re[4]: HP nw8000 never wakes up from acpi suspend
Date: Sun, 10 Oct 2004 00:21:16 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8405BD1229@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Vadim Zeitlin <vadim-oE/GLL+f5xMgsBAKwltoeQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20

>YL> > I should say that nothing happens when I do "echo -n disk (or=20
>YL> >standby) >
>YL> >/sys/power/state" but when I do "echo mem >=20
>/sys/power/state" I can see
>YL> >messages on the console saying "PM entering sleep state"=20
>(I'm not sure,
>YL> >they disappear too quickly and syslog is apparently not=20
>written to any
>YL> >more) and the machine does indeed fall asleep -- but=20
>doesn't wake up.
>YL>=20
>YL> It sounds like VGA issue.
>
> Is there any workaround?

Please reference document: linux/Documentation/power/video.txt

>
>YL> >YL> There is a known S3 VGA resume issue on some laptop.=20
>YL> >YL> Maybe you will hit that bug. Please verify.
>YL> >
>YL> > What should I do to verify this? Just in case, the video=20
>card is ATI
>YL> >OpenGL T2.
>YL>=20
>YL> Please try "echo mem > /sys/power/state" from X window.
>
> Same thing: it goes to sleep and doesn't wake up.
>
> I've recompiled the kernel with ACPI debugging turned on and=20
>did (please
>tell me if it was wrong as I don't really understand it, just found on
>in this list archives):
>
>	echo 0x10 > /proc/acpi/debug_level=20
>	echo 0x1f > /proc/acpi/debug_layer
>
>However this didn't give any useful messages (or I couldn't see it).

Basically, we use this debug mechanism to debug ACPI subsystem itself.
The suspend/resume issue is system wide. I guess these debug
information will not help you, before you can affirm ACPI subsystem has
bug.

>
> What else can I do?

Maybe you need to remove some driver like USB.... , and make
sure the resume process can reach some point.

Thanks,
Luming


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
