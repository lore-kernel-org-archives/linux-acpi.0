From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Battery status wrong from 2.6.7 when running on batteries
Date: Thu, 28 Oct 2004 20:12:04 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0410282005580.4042@frog.athome>
References: <16768.60745.952949.338093@aber.ac.uk> <16769.6764.210990.366655@aber.ac.uk>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16769.6764.210990.366655-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Fred,
On Thu, 28 Oct 2004, Fred Labrosse wrote:
> > I have been upgrading my kernel regularly and since 2.6.7 (included), the
> > battery status is wrong, but apparently only when I run on the battery, not
> > when on AC.  It starts off alright and after a while it is just not updated
> > anymore.  It seems that the temperature does the same.
>
> I confirm that the temperature does the same.  I just experienced a reading
> of 99C on both zones, while the fan was apparently working as usual.
typically it should be something like this:
temperature:             45 C
temperature:             55 C

> > Works fine under 2.6.6.
works perfekt under 2.6.9

> One more precision.  It's an Acer TM 636.
TM 634 (which has the same hardware, except for featuring only 1.8GHz... 
processor).
Is your BIOS the latest. I just ask, because of the temperature problem, 
which I cannot see. There is only once every few months a wrong 
temerature, that triggers an Linux-emergency shutdown.

With your reboot-problem: Do you have configured high-precision Timers? 
Use the generic-RTC driver. Do not use APIC/LAPIC.

Please tell use, how your millage would be.
Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBgTZ49bBoTzOf1pMRAgF0AJ4nKuFuh9C1dTy1CTxAlZrSrKewQgCg5Qn7
I+IeYpVeNzA1OOv57/1mJK4=
=5qpN
-----END PGP SIGNATURE-----


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
