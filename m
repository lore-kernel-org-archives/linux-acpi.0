From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Asus L5D resume on battery power
Date: Fri, 25 Feb 2005 22:37:03 +0100
Message-ID: <200502252237.04110.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
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
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

For quite some time I've been trying to make my Asus L5D box (athlon64, nforce3,
64-bit kernel, SuSE 9.2) resume from suspend (S4, ie swsusp) on battery power.
Evidently, the box always resumes successfully on AC power, but there are
problems with resuming on battery power.

I've tried all of the recent -mm kernels and it turns out that the box resumes
successfully for 2.6.11-rc3-mm2, but for either 2.6.11-rc3-mm1 or 2.6.11-rc4-mm1
it (most often) reboots as soon as the image has been restored (ie before
executing the last pr_debug() in pm_suspend_disk()).  Hence, it seems that
there's something in 2.6.11-rc3-mm2 which makes the box resume sucessfully and
is not present in the other kernels.  I'm not absolutely convinced that it is
related to ACPI, but I suspect so.  I'd like to find out what exactly it is
so if you can give me a hint, please do.

BTW, for each of the above kernels, if the resume on battery power is successful
(it sometimes happens for 2.6.11-rc3-mm1 or 2.6.11-rc4-mm1 too, but quite
rarely, so to speak), the box cannot be switched back to AC power after
resume, because it usually hangs solid as soon as the power supply is
connected to it.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
