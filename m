From: Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org>
Subject: no events with acpi-20020821-2.4.19 (fwd)
Date: Sat, 24 Aug 2002 19:55:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020824195536.C587@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: ehikory-Ru1csStN2yCTnpBtbRfDVg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

----- Forwarded message from ehikory-Ru1csStN2yCTnpBtbRfDVg@public.gmane.org -----

My mail provider does not comply with RFC822, and my mail to
acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org was rejected.  Would you be
kind enough to forward this message to the list?  I will check the
archives to follow the thread.  Thank you.

-------- Forwarded Message ---------
Subject: No events with acpi-20020821-2.4.19

    After installing a 2.4.19 kernel with the acpi-20020821-2.4.19 patch, I get
no events reported from /proc/acpi/events.  Events were being reported with the
ACPI support in the vanilla kernel.  I'm running on a Sony VAIO PCG-Z505HE, and
`acpidmp FACP | acpitbl` reports OEMID: Sony, TableID: Z1, revision: 0x20000222.

    My syslog looks clean (ACPI loads, with lots of detail, but no errors).

    Additionally, although sleep didn't work quite right with the vanilla kernel
(no wakeup functions), I now get no response from `echo 1 > /proc/acpi/sleep` and
receive a "write error: no such device" when using `cat foo > /proc/acpi/sleep`,
where foo contains only the numeral "1".

    Has anyone else experienced this behavior, or do I just need to update my
BIOS?  Any pointers to additional documentation would also be welcome.  Also,
if anyone wants detailed debugging information, I would be happy to send it
off-list: just let me know what you need.

-- 
Emmet Hikory
ehikory-Ru1csStN2yCTnpBtbRfDVg@public.gmane.org
--------- End of Forwarded Message ---------

----- End forwarded message -----


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
