From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: ACPI S1 problem
Date: Fri, 8 Oct 2004 18:00:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041008160034.GB10581@message-id.gmane0305.slipkontur.de>
References: <1096813379.2753.9.camel@tiger>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1096813379.2753.9.camel@tiger>
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


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 03, 2004 at 04:22:59PM +0200, Kenneth Johansson wrote:

 
> For some reason  mysql do not want to play 
> --
> kernel: Stopping tasks: ===================================================================================
> kernel:  stopping tasks failed (1 tasks remaining)
> kernel: Restarting tasks...<6> Strange, mysqld not stopped
> --
> 
> After stopping mysql by hand I still have problem. 

Pavel sent a patch for this to lkml (works with swsusp), i'll attach it.

> kernel: Stopping tasks: ======================================================================|
> kernel: NVRM: ACPI: device not initialized!
> kernel: Could not suspend device 0000:01:00.0: error -1
> kernel: Restarting tasks... done
> --
> That device is the graphics card. 
> 0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0045 (rev a1)
> 
> I have seen that others have this working with nvidia card why dose it not work for me?

get rid of the binary only NVidia driver if you want suspend/standby now.
They are working on it but this may take some time, you know.
-- 
Stefan Seyfried

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="swsusp-mysql.patch"

--- clean/kernel/signal.c	2004-08-15 19:15:06.000000000 +0200
+++ linux/kernel/signal.c	2004-08-15 19:35:44.000000000 +0200
@@ -1433,9 +1433,7 @@
 	int why, status;
 	struct sighand_struct *psig;
 
-	if (sig == -1)
-		BUG();
-
+	BUG_ON(sig == -1);
 	BUG_ON(tsk->group_leader != tsk && tsk->group_leader->state != TASK_ZOMBIE && !tsk->ptrace);
 	BUG_ON(tsk->group_leader == tsk && !thread_group_empty(tsk) && !tsk->ptrace);
 
@@ -2162,6 +2160,8 @@
 		if (timeout)
 			ret = -EINTR;
 	}
+	if (current->flags & PF_FREEZE)
+		refrigerator(1);
 
 	return ret;
 }

--UugvWAfsgieZRqgk--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
