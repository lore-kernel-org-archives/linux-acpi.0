From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: [Bugme-new] [Bug 5067] New: [Patch] Hotkeys do not work on
 Samsung P30
Date: Mon, 15 Aug 2005 08:46:18 -0700
Message-ID: <20050815084618.50f3cceb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: siprbaum-t+0fs1LuQyGVdxy9aTz+TW+fIWL0DMyzU2kT9rkj4NY@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This seems fairly serious.  Is that patch appropriate to 2.6.13?



Begin forwarded message:

Date: Mon, 15 Aug 2005 07:26:54 -0700
From: bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
To: bugme-new-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Subject: [Bugme-new] [Bug 5067] New: [Patch] Hotkeys do not work on Samsung P30


http://bugzilla.kernel.org/show_bug.cgi?id=5067

           Summary: [Patch] Hotkeys do not work on Samsung P30
    Kernel Version: 2.6.13-rc5
            Status: NEW
          Severity: normal
             Owner: other_modules-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
         Submitter: siprbaum-t+0fs1LuQyGVdxy9aTz+TW+fIWL0DMyzU2kT9rkj4NY@public.gmane.org
                CC: siprbaum-t+0fs1LuQyGVdxy9aTz+TW+fIWL0DMyzU2kT9rkj4NY@public.gmane.org


Distribution: debian sarge
Hardware Environment: Samsung P30
Software Environment:
Problem Description:
I get an OOPS if I try to load asus_acpi as modul. After a little googling I find 
this link with the a patch wich solved my problem. Applying this made my hotkeys
work again.

http://sourceforge.net/mailarchive/message.php?msg_id=12203231

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
