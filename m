From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI patch status (2.6)
Date: 30 Sep 2003 13:07:38 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1064941658.2576.61.camel@dhcppc4>
References: <1064902694.2535.159.camel@dhcppc4>
	 <20030929235203.O79536@root.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030929235203.O79536-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Is there a good facility where you track patches that I
> should submit them instead?

Always learning, but the best process I know goes something like below.
In summary, the mailing list is great, but if you want to be sure an
issue and its fix get properly handled and don't fall through the
cracks, then bugzilla is your friend.

thanks,
-Len


1. issue discovered

2. Check to see if somebody else already discoverd it

	Query bugzilla -- http://bugzilla.kernel.org/
	and/or at the distro bugzilla.

	google for it
	poke around the list archives
	http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel
	http://sourceforge.net/mailarchive/forum.php?forum=acpi-support

3. If no, ask others if they see the same problem or have a fix
	acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
	acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

4. If no, file a new bug
	http://bugzilla.kernel.org/ for base 2.4 or 2.6 kernels
		Category: Power Management
		Component: ACPI
	http://bugzilla.redhat.com/ for RHEL, Fedora etc.
	http://bugzilla.suse.de for SuSE
	etc.

	Put useful stuff in the bug report.  Eg. for interrupt issues:

	Please attach the output from dmidecode, available in
	/usr/sbin/, or here: http://www.nongnu.org/dmidecode/

	Please attach the output from acpidmp, available in /usr/sbin/,
	or in here
	http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz
	Please attach /proc/interrupts and the dmesg output
	showing the failure, if possible.

5. Debug
	As bug is debugged, attach the useful stuff to the bug report --
	don't just send it to the mailing list or it may get lost.

	Attach proposed patches in bugzilla.
	Submitter tests proposed patch and verifies it works.
	bugzilla should be set to RESOLVED w/ CODE_FIX at this point.

6. Get it integrated
	If I haven't noticed the bugzilla and picked up the fix
	already, send me a pointer to it and 
	cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
	to make sure others get the opportunity to be aware of
	the proposed change.

7. Receive notice it is integrated.
	When I pull in a patch, I'll reply to the contributor
	and will cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
	I'll cc LKML too if that is where it came from
	so the ACK is included in the thread.
	

8. Test the fix along with the others.
	Your pristine fix may have been toasted along the way.
	Update from the latest BK tree
	http://linux-acpi.bkbits.net/linux-acpi-test-2.4.22
	http://linux-acpi.bkbits.net/linux-acpi-test-2.4.23
	http://linux-acpi.bkbits.net/linux-acpi-test-2.6.0

	Or apply the plain patches from here:
	ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test

	(See README here:
	ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.ACPI

	And let me know if it got broke.

9. ACPI test tree periodicaly gets released to baseline kernel
	When the fix is in the base kernel,
	bugzilla should be marked CLOSED.





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
