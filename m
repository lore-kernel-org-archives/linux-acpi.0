From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Method execution failed
Date: Fri, 06 Aug 2004 10:48:13 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1091810893.3855.29.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


   I think there's a locking issue w/ namespace for concurrent calls to
acpi_evaluate_object().  FWIW, these concurrent calls are coming in
through my acpi sysfs patch, so it could be a bug in that code.  If I
serialize calls into acpi_evaluate_object(), it works fine, but I don't
see a global lock for this, so I think the problem is more general.  If
I make lots of calls to evaluate the same _BBN object, I start seeing
these:

ACPI-0279: *** Error: Looking up [LBAS] in namespace, AE_ALREADY_EXISTS
ACPI-1133: *** Error: Method execution failed [\LBA_.BBN_] (Node e00000407fd

This starts at acpi_ds_load1_begin_op() doing a path lookup, presumably
expecting not to find the path with flag ACPI_NS_ERROR_IF_FOUND.  The
AML for the method is:

0000000: a45c 2e4c 4241 5f42 424e 5f5e 5f55 4944  .\.LBA_BBN_^_UID

The first part of the _SB/LBA/BBN_ AML looks like this:

0000000: 084c 4241 5311 030a 408a 4c42 4153 0056  .LBAS...@.LBAS.V
0000010: 414c 448a 4c42 4153 0a04 4c46 4c47 8a4c  ALD.LBAS..LFLG.L
...

The LBA/BBN_ method appears to make an object named LBAS.  When calling
this multiple times, each instance wants to not find this object and
then create it.  However, the namespace lock is given up around method
execution, so it seems we have some races.  Am I completely mis-
interpreting the problem, or does this sound plausible?  I don't really
know how to read AML, so this is just a guess.  Do we need to be more
stringent on locking namespace, or is there a bug in the AML I'm
calling?  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
