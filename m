From: Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>
Subject: Re: ACPI: S3 and PAE do not like each other for now, S3 disabled.
Date: Fri, 6 Aug 2004 02:09:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408060209.55067.arekm@pld-linux.org>
References: <200407252330.05542.arekm@pld-linux.org> <20040726210011.GB21889@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040726210011.GB21889-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 26 of July 2004 23:00, Pavel Machek wrote:
> Hi!
>
> > Is this ,,ACPI: S3 and PAE do not like each other for now, S3 disabled.=
''
> > generic S3 and PAE issue or just Linux issue only?
>
> Linux only. Hmm with recent enough kernel we needed to fix this for
> different reason, so it might just work.
>
> Remove check, test it, if it works submit a patch.
Today while playing with suspend/resume support in via-rhine I had a chance=
 to=20
try it few more times (on 2.6.8rc2 with PAE enabled, maxdata notebook, 512M=
B=20
ram, athlon, kt133 based mainboard).

Resuming works properly only somethimes. Once I have system back into nice=
=20
shape, once I see that it starts resuming (fans are starting, screen change=
s)=20
and it hangs, screen is corrupted (some color characters flashing), sysrq=20
doesn't work.

> 				Pavel

=2D-=20
Arkadiusz Mi=B6kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
