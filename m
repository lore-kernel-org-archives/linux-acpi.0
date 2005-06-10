From: Frank Siegert <hugelmopf-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: Resume from Suspend to RAM))
Date: Fri, 10 Jun 2005 20:49:41 +0200
Message-ID: <200506102049.42313.hugelmopf@vodafone.de>
References: <200506061531.41132.stefandoesinger@gmx.at> <200506071732.23095.hugelmopf@web.de> <1118193341.3857.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1118193341.3857.4.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
Content-Disposition: inline
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

> > Against which kernel version/tree does this patch go? I would be happy =
to
> > test it, but I am pretty new to kernel patching, so this is not so
> > obvious to me.
>
> I think any kernel version should be ok, but please try latest kernel.
> Please note, this isn't a fix but a test case.
> If the test failed, then suspend/resume code path or drivers are broken.
> If the test succeeded, then
> 	1. Linux forgot doing something BIOS lets it do
> 	or 2. BIOS is broken.

Sorry for rather being newbish than much of a help, but I'd like to try thi=
s out=20
and find out whether it's Linux or my notebook that has the problems.

But it gives me problems.
1. The patch won't apply or I am doing something wrong:
| [20:38 frank: ~/downloads/linux-2.6.12-rc6]$ patch -p1 <patch_resume.diff
| patching file drivers/acpi/hardware/hwsleep.c
| Hunk #2 FAILED at 328.
| 1 out of 2 hunks FAILED -- saving rejects to file drivers/acpi/hardware/h=
wsleep.c.rej

(same for linux-2.6.11.9)

2. I tried to add the patch manually (and can't see where I missed somethin=
g -- the
"extern void machine_real_restart(...)" line exists), but kernel compilatio=
n then fails.
|   CC      init/version.o
|   LD      init/built-in.o
|   LD      .tmp_vmlinux1
| ld: BFD 2.15 assertion fail ../../bfd/linker.c:619
| drivers/built-in.o(.text+0x203ef): In function `acpi_enter_sleep_state':
| : undefined reference to `machine_real_restart'
| make[1]: *** [.tmp_vmlinux1] Fehler 1
| make[1]: Verlasse Verzeichnis =BB/usr/src/linux-2.6.12-rc6=AB
| make: *** [stamp-build] Fehler 2

Would you mind posting the patch as attachment and the exact command I have=
 to=20
issue in my kernel directory?

Thanks a lot,
=46rank


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
