From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: [SoftwareSuspend-devel] status update for current development on ASUS M2N
Date: Thu, 30 Sep 2004 11:59:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3oejo84bp.fsf@brain.gnuhh.org>
References: <m3lleww12c.fsf@brain.gnuhh.org>
	<1096279213.4222.5.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="20040930115954+0200-460673367056891766230955"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1096279213.4222.5.camel-AdgCB+f5QAxwBzq2CxEN2SkBHpOjBR89@public.gmane.org> (Nigel Cunningham's
	message of "Mon, 27 Sep 2004 20:11:41 +1000")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, SoftwareSuspend-Devel <softwaresuspend-devel-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--20040930115954+0200-460673367056891766230955

 || On Mon, 27 Sep 2004 20:11:41 +1000
 || Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org> wrote: 

 nc> Could I get you to compile kdb in as well. If you then press the
 nc> Sys Rq key when the CPU is being chewed, you should be able to
 nc> use ps and btp <process number> to get an idea of what is going
 nc> on.

I am now running kernel

--20040930115954+0200-460673367056891766230955
Content-Disposition: attachment; filename=patch-2.6.9-rc2-plus_5.txt

Patches contained:

linux-2.6.8
patch-2.6.9-rc2

software-suspend-109-for-2.6.9-rc2 (without kdb)
build fix for swsusp 109 - see https://lists.berlios.de/pipermail/softwaresuspend-devel/2004-September/000555.html

2.6.9-rc2-mm4/bk-acpi.patch
	acpi-compile-fix.patch
	acpi-x86_64-build-fix.patch
	bk-agpgart.patch
	bk-alsa.patch
	bk-cpufreq.patch

ipw2100-0.55

arch/i386/kernel/i8259.c:

  * changed device_initcall(i8259A_init_sysfs);
         to late_initcall(i8259A_init_sysfs);
    (needed for suspend to RAM)

Makefile:

  * added -plus version


--20040930115954+0200-460673367056891766230955


and also created a version with kdb and heavy debugging.

This kernel shows the same behaviour and can suspend/resume so I can
get into kdb and do btp. Unfortunately I seem to be too stupid to find
the way to get the output somehow saved or written anywhere.

Not having the time (and motivation, to be honest) to write down all
the names and numbers -- and also not feeling that sending digital
photographs is the best way of communicating that output -- I don't
know how to give you that information.

Can you tell me how to do this, please?

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20040930115954+0200-460673367056891766230955--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
