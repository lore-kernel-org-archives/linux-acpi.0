From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: ACPI: S3 and PAE do not like each other for now, S3 disabled.
Date: Fri, 6 Aug 2004 21:18:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040806191822.GE3048@elf.ucw.cz>
References: <200407252330.05542.arekm@pld-linux.org> <20040726210011.GB21889@openzaurus.ucw.cz> <200408060209.55067.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200408060209.55067.arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Is this ,,ACPI: S3 and PAE do not like each other for now, S3 disabled.''
> > > generic S3 and PAE issue or just Linux issue only?
> >
> > Linux only. Hmm with recent enough kernel we needed to fix this for
> > different reason, so it might just work.
> >
> > Remove check, test it, if it works submit a patch.
> Today while playing with suspend/resume support in via-rhine I had a chance to 
> try it few more times (on 2.6.8rc2 with PAE enabled, maxdata notebook, 512MB 
> ram, athlon, kt133 based mainboard).
> 
> Resuming works properly only somethimes. Once I have system back into nice 
> shape, once I see that it starts resuming (fans are starting, screen changes) 
> and it hangs, screen is corrupted (some color characters flashing), sysrq 
> doesn't work.

Can you confirm that it works reliably with PAE disabled?

S3 is doing something "interesting" with page tables (switching to 1:1
mapping etc), it probably needs some hand-checking to see that it is
not non-PAE-specific.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
