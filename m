From: Christoph Tavan <chefturner-S0/GAf8tV78@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: Resume from Suspend to RAM))
Date: Sun, 12 Jun 2005 22:55:37 +0200
Message-ID: <200506122255.38020.chefturner@web.de>
References: <200506061531.41132.stefandoesinger@gmx.at> <1118193341.3857.4.camel@linux-hp.sh.intel.com> <200506102049.42313.hugelmopf@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506102049.42313.hugelmopf-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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

On Friday 10 June 2005 20:49, Frank Siegert wrote:
> 2. I tried to add the patch manually (and can't see where I missed
> something -- the "extern void machine_real_restart(...)" line exists), but
> kernel compilation then fails.
>
> | =A0 CC =A0 =A0 =A0init/version.o
> | =A0 LD =A0 =A0 =A0init/built-in.o
> | =A0 LD =A0 =A0 =A0.tmp_vmlinux1
> | ld: BFD 2.15 assertion fail ../../bfd/linker.c:619
> |
> | drivers/built-in.o(.text+0x203ef): In function `acpi_enter_sleep_state':
> | : undefined reference to `machine_real_restart'
> |
> | make[1]: *** [.tmp_vmlinux1] Fehler 1
> | make[1]: Verlasse Verzeichnis =BB/usr/src/linux-2.6.12-rc6=AB
> | make: *** [stamp-build] Fehler 2

I get exactly the same error. I also would like to test that patch, but I=20
cannot compile the sources with that patch applied.

> Would you mind posting the patch as attachment and the exact command I ha=
ve
> to issue in my kernel directory?

That would be great!!!

Thanks, Christoph Tavan


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
