From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Battery status wrong from 2.6.7 when running on batteries
Date: Sun, 7 Nov 2004 01:12:56 +0100
Message-ID: <20041107001256.GA8624@hell.org.pl>
References: <16768.60745.952949.338093@aber.ac.uk> <16769.6764.210990.366655@aber.ac.uk> <Pine.LNX.4.60.0410282005580.4042@frog.athome> <16769.64228.751344.828301@aber.ac.uk> <Pine.LNX.4.60.0410291255100.1318@frog.athome> <16770.21398.497934.189008@aber.ac.uk> <Pine.LNX.4.60.0410301303050.1003@frog.athome> <16774.14973.261012.528478@aber.ac.uk> <Pine.LNX.4.60.0411062253560.5414@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0411062253560.5414-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Thus wrote hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org:
> There is a bad workaround for our laptops: If you close the lid, it will 
> not restart. That is a protective rule in the BIOS that should prevent the 
> laptop to start while in it's covered in its bag (I suppose).

That, or there's some sort of PM (APM stand-by?) going on when the lid is
closed _and_ ACPI is off. Try booting with acpi=off and close the lid --
see particularly if the NIC responds or if the timer interrupts go off.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
