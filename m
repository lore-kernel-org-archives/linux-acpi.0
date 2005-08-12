From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: (fwd) [Bug 5049] New: doubled keystrokes especially with 'acpi'
Date: Fri, 12 Aug 2005 05:25:02 +0100
Message-ID: <E1E3R6M-0001ys-00@skye.ra.phy.cam.ac.uk>
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

[Is it good form to post new bug reports to bugzilla (I know Andrew
 M. likes them to go there) and to the acpi-devel list, so that more
 eyes have a look?  -S]

------- Forwarded Message

Date:    Thu, 11 Aug 2005 20:56:51 -0700
From:    bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
To:      sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org
Subject: [Bug 5049] New: doubled keystrokes especially with 'acpi'

http://bugzilla.kernel.org/show_bug.cgi?id=5049

           Summary: doubled keystrokes especially with 'acpi'
    Kernel Version: 2.6.13-rc6
            Status: NEW
          Severity: normal
             Owner: acpi_other-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
         Submitter: sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org


Latest kernel w/o this: It's old, at least back to 2.6.11
Distribution: Debian testing
Hardware Environment: TP 600X
Software Environment:  See Bug #4989 for acpidmp output.

Problem Description: Quite often my keystrokes are doubled.  If I'm
typing in emacs, that shows up as "mainn () {" for example.  At first
I thought my typing had got sloppy, or my autorepeat delay was too
low, but I doubt it because I can reproduce the problem using 'acpi':

# acpi

     Battery 1: charged, 100%
     Battery 2: charged, 100%
# 
# 

Notice the blank line after running acpi, which I think is a doubling
of the <RETURN> at the end of the 'acpi' line.  And the shell grabs
the second <RETURN> and produces the last # line.

I think, but don't swear to it, that the problem went away when I
compiled the kernel with preempts; and maybe also when EC burst mode
was enabled.

The reason I suspect it's related to acpi and/or EC is that I just got
rid of the problem of doubling keystrokes in Emacs (unless I run
'acpi', which always gives me the doubling): by setting the
thermal-zone polling intervals to 0 (no polling).  Whereas I usually
set it to 10 seconds.

So my guess is that when acpi either polls for new temperatures, or
asks for the battery state (via 'acpi'), the system will double
whatever key I have typed in that narrow time slice.

Steps to reproduce: Run 'acpi'

- ------- You are receiving this mail because: -------
You reported the bug, or are watching the reporter.

------- End of Forwarded Message



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
