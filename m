From: Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] Re: Cause of Suspend2 resume failures on
	Toshiba laptops
Date: Sun, 6 Mar 2005 13:33:35 +0100
Message-ID: <20050306123334.GN3485@openzaurus.ucw.cz>
References: <20050304175058.GA4042@blackham.com.au>
	<1110012298.6028.10.camel@DustPuppy.LNX.RO>
	<20050305100254.GH4042@blackham.com.au>
	<20050305175640.GL3485@openzaurus.ucw.cz>
	<20050305203533.GI4042@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305203533.GI4042@blackham.com.au>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Pavel Machek <pavel@suse.cz>, Dumitru Ciobarcianu <swsusp-devel@lnx.ro>, acpi-devel@lists.sourceforge.net, suspend2-devel@lists.suspend2.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Perhaps you should fix that, too? It is going to cause ugly
> > perfrmance problems.
> 
> Yep, been looking into it, and I think I've got it. The GPE in
> question is fired periodically, about every 5 seconds. It fires when
> suspending but kacpid is stopped, so the GPE is simply disabled and
> never serviced. However, the state of it being disabled is recorded
> in the atomic copy.
> 
> Upon resume, after restoring the atomic copy, the code at the top of
> acpi_ev_disable_gpe believes that the GPE is already disabled (as it
> was when we suspended) even though it's not. Hardware state is out
> of sync with what the kernel thinks and badness ensues. The culprit
> difference between 2.6.8 and 2.6.9-rc1 is that 2.6.8 disabled the
> GPE unconditionally, 2.6.9-rc1 checks against its last known state
> which is incorrect upon resuming.
> 
> Removing the check resolves this issue (patch attached). Is this an
> adequate fix?

Does not removing of the check cause problems elsewhere? Bring it up
on linix-acpi lists...

Obvious solution would be to add suspend/resume routines to acpi,
and properly set the flag during resume.

> So, combining this patch with the previous kacpid NOFREEZE patch...
> Does this make people happy? :) (And should it be submitted via Len
> or akpm?)

Len.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
