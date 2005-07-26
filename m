From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Another secret of Clevo D610SU: Hidden IOAPIC ?
Date: Tue, 26 Jul 2005 23:19:16 +0200
Message-ID: <20050726211916.GA5084@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello,
  first of all, I hope that my questions are not boring or otherwise improper.
  If so, please let me know, I will shut up.

  My Clevo D610SU in his BIOS chipset info writes somthing like SIS630+APIC.
I think they mean IOAPIC, because LAPIC is a part of the CPU.
  In the DSDT, there is really the _PIC method, which stores its argument to
the internal variable called PICF, and in the _PRT method, they do

            Method (_PRT, 0, NotSerialized)
            {
                If (LNot (PICF))
                {
                    Return (PICM)
                }
                Else
                {
                    Return (APIC)
                }
            }

  .. so they return either XT-PIC or APIC object, depending on a formerly
requested PIC mode.
  However, MADT is not present in the system. Even the LAPIC should be
discovered using the lapic kernel option.
  So, I'm curious: Is there a possibility (maybe just hypothetically, not
yet implemented) to "discover" the IOAPIC (if really present) and use it by
Linux ? It would decrease a degree of irq sharing, thus maybe improve the
performance a bit, or also fix some other interrupt problems, which are
still there.

                              With regards, Pavel Troller



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
