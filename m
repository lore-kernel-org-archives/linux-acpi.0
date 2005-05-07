From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: Resume -> higher power drain?
Date: Sat, 07 May 2005 17:27:55 +0200
Message-ID: <427CDE7B.5040306@kernelconcepts.de>
References: <427CC869.1050506@kernelconcepts.de> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <1115475297.10424.4.camel@localhost> <20050507144417.GA3100@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050507144417.GA3100-JwFqNg2GrOVrgjWwlLH9qw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: =?ISO-8859-15?Q?Hendrik_J=FCrgens?= <hjuerg-ULHALamj7Vx/+Jgy1241yg@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dominik Brodowski wrote:
> On a P35, a friend of mine determined that suspend to mem leads to a higher
> power consumption if X was running. But only when using the ATI driver. When
> using the vesa driver, the power consumption is increased to a higher rate 
> all the time...

You can decrease power with the x.org drivers and using the
	Option          "DynamicClocks" "on"
in the device sectio of xorg.conf. This will enable dynamic clock
scaling in the Radeon Fire GL and save quite some power.

> Other than the video driver, you can check whether PCI devices changed their
> status (they shouldn't) by doing "lspci -vvv > lspci_before.txt" before
> suspend, "lspci -vvv > lspci_after.txt" after suspend, and checking 
> "diff -u lspci_before.txt lspci_after.txt".

Just did that, no change so it seems PCI is safe.

> Also, does the bus master activity rates typically seen (check 
> /proc/acpi/processor/*/power every once in a while) differ
> between pre-suspend and post-suspend?

This again is interesting!
What does this bus master activity indicate?

Before suspend I see the CPU sporadically changing from C2 to C3 and
back and bus master activity to have values between 00000000 and some
higher values on activity, like 00200000 or even f0000000.

After suspend/resume this changed!
The CPU is now fixed at C2 and does not switch between C2 and C3.
Also the bus master activity is ffffffff in idle state and changes to
strange values on activity, like f7ffffff - quite different than before.

So, good spot!
And where can we go from here?
Is this already the possible cause?

> 	Dominik
CU
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCfN57JXeIURG1qHgRAuKhAJoDzbAK6oN/2l+1/t6h5/mM3adGGQCfUFBy
1uLU7TtifkeGf2DVmKqE8K8=
=hprp
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
