From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: ACPI failures on non-Intel hardware
Date: Sat, 11 Dec 2004 22:47:59 +0000
Message-ID: <1102805280.5984.30.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

http://bugzilla.kernel.org/show_bug.cgi?id=3691 describes a fairly
serious ACPI failure. Attempting to wake up from S3 suspend seems to
result in the system rebooting without any wakeup code being run. I've
seen this behaviour on two machines, and had it described to me on a
third. Interestingly, all the machines in question were non-Intel
hardware - one is a VIA C3, and the other two are Athlon XPs (not
Athlon64s). On the test machine I have here, FreeBSD behaves identically
to Linux (seemingly successful suspend, reboot on wake) and Windows
suspends and resumes correctly.

The fact that I've only seen this on systems that didn't have Intel
motherboard chipsets makes me wonder whether there's something going
wrong during the suspend code that happens to work by chance on Intel
(and a few other) chipsets, or alternatively whether these chipsets
manage to fall outside the specs slightly. Any ideas?

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
