From: Bernard Blackham <bernard@blackham.com.au>
Subject: Re: [ACPI] Re: Cause of Suspend2 resume failures on
	Toshiba laptops
Date: Sun, 6 Mar 2005 04:35:33 +0800
Message-ID: <20050305203533.GI4042@blackham.com.au>
References: <20050304175058.GA4042@blackham.com.au>
	<1110012298.6028.10.camel@DustPuppy.LNX.RO>
	<20050305100254.GH4042@blackham.com.au>
	<20050305175640.GL3485@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <20050305175640.GL3485@openzaurus.ucw.cz>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Pavel Machek <pavel@suse.cz>
Cc: acpi-devel@lists.sourceforge.net, suspend2-devel@lists.suspend2.net
List-Id: linux-acpi@vger.kernel.org


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 05, 2005 at 06:56:41PM +0100, Pavel Machek wrote:
> > After more investigation, it seems that the issue is the GPE is
> > fired but not serviced because kacpid is frozen. This in itself
> > would be okay, however, the GPE isn't being disabled before the
> > method executes (despite there being code there to do so), and hence
> > fires continuously.
> 
> Perhaps you should fix that, too? It is going to cause ugly
> perfrmance problems.

Yep, been looking into it, and I think I've got it. The GPE in
question is fired periodically, about every 5 seconds. It fires when
suspending but kacpid is stopped, so the GPE is simply disabled and
never serviced. However, the state of it being disabled is recorded
in the atomic copy.

Upon resume, after restoring the atomic copy, the code at the top of
acpi_ev_disable_gpe believes that the GPE is already disabled (as it
was when we suspended) even though it's not. Hardware state is out
of sync with what the kernel thinks and badness ensues. The culprit
difference between 2.6.8 and 2.6.9-rc1 is that 2.6.8 disabled the
GPE unconditionally, 2.6.9-rc1 checks against its last known state
which is incorrect upon resuming.

Removing the check resolves this issue (patch attached). Is this an
adequate fix?

> Looks good to me. It is good idea for other reasons, too: like
> we'll be able to fight overheat during writing pages.

Fair enough. Even with kacpid running, we may still potentially run
into the same issue if a GPE occurs at the instant prior to the
atomic copy (and gets disabled in the atomic copy).

So, combining this patch with the previous kacpid NOFREEZE patch...
Does this make people happy? :) (And should it be submitted via Len
or akpm?)

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>

--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="toshiba-acpi-hack-3.diff"

--- linux-2.6.9-rc1/drivers/acpi/events/evgpe.c.orig	2005-03-06 04:29:40.000000000 +0800
+++ linux-2.6.9-rc1/drivers/acpi/events/evgpe.c	2005-03-06 04:29:49.000000000 +0800
@@ -253,10 +253,6 @@
 	ACPI_FUNCTION_TRACE ("ev_disable_gpe");
 
 
-	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
-		return_ACPI_STATUS (AE_OK);
-	}
-
 	/* Make sure HW enable masks are updated */
 
 	status = acpi_ev_update_gpe_enable_masks (gpe_event_info, ACPI_GPE_DISABLE);

--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Suspend2-devel mailing list
Suspend2-devel@lists.suspend2.net
http://lists.suspend2.net/mailman/listinfo/suspend2-devel

--5xSkJheCpeK0RUEJ--
