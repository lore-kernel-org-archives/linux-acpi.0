From: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: Battery status wrong from 2.6.7 when running on batteries
Date: Fri, 29 Oct 2004 09:10:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16769.64228.751344.828301@aber.ac.uk>
References: <16768.60745.952949.338093@aber.ac.uk>
	<16769.6764.210990.366655@aber.ac.uk>
	<Pine.LNX.4.60.0410282005580.4042@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0410282005580.4042-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org writes:
 > -----BEGIN PGP SIGNED MESSAGE-----
 > Hash: SHA1
 > 
 > Salut Fred,
 > On Thu, 28 Oct 2004, Fred Labrosse wrote:
 > > > I have been upgrading my kernel regularly and since 2.6.7 (included), the
 > > > battery status is wrong, but apparently only when I run on the battery, not
 > > > when on AC.  It starts off alright and after a while it is just not updated
 > > > anymore.  It seems that the temperature does the same.
 > >
 > > I confirm that the temperature does the same.  I just experienced a reading
 > > of 99C on both zones, while the fan was apparently working as usual.
 > typically it should be something like this:
 > temperature:             45 C
 > temperature:             55 C

Here is what I have at the moment:

> acpi -t
     Thermal 1: ok, 46.0 degrees C
     Thermal 2: ok, 45.0 degrees C

However, if I now run on battery, after a while it stops working (is not
updated anymore, and last time was at 99C).  The battery charge does the
same.

I just tried it again.  After about 1.5 min, both temperatures are at 45.0C
and the battery level jumped from 97% charged to 45% charged (is the 45 a
clue????).

Interestingly enough, when it does it (I mean, not working after having
been on batteries), when I /sbin/halt, it does not power down (just prints
"Power down" and stays there).  When I stay on AC, /sbin/halt powers down
the computer which restarts immediately after (see my other post on that).

 > 
 > > > Works fine under 2.6.6.
 > works perfekt under 2.6.9
 > 
 > > One more precision.  It's an Acer TM 636.
 > TM 634 (which has the same hardware, except for featuring only 1.8GHz... 
 > processor).
 > Is your BIOS the latest.

BIOS version is: V4R6.1 R01-C0O.  Is that the latest?

 > I just ask, because of the temperature problem, 
 > which I cannot see. There is only once every few months a wrong 
 > temerature, that triggers an Linux-emergency shutdown.

I use to have that quite often, but only had it once in a very long while.

 > 
 > With your reboot-problem: Do you have configured high-precision Timers? 
 > Use the generic-RTC driver. Do not use APIC/LAPIC.

I know about that (already fixed it in 2.6.6).  Just to verify, I tried
different combinations, which didn't change anything.  What about the HPET
thing that appears in many different places in the config?

Fred



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
