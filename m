From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: ACPI using smp_processor_id in preemptible code
Date: Mon, 10 Jan 2005 21:09:48 -0500
Message-ID: <200501102109.51513.dtor_core@ameritech.net>
References: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com> <20050110095508.GJ1353@elf.ucw.cz> <1105405464.18834.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1105405464.18834.4.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 10 January 2005 08:04 pm, Li Shaohua wrote:
> On Mon, 2005-01-10 at 17:55, Pavel Machek wrote:
> > > >I enabled CPU hotplug and preemptible debugging... now I get...
> > > >
> > > >BUG: using smp_processor_id() in preemptible [00000001] code:
> > > >swapper/0
> > > >caller is acpi_processor_idle+0xb/0x235
> > > > [<c020ba28>] smp_processor_id+0xa8/0xc0
> > > > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > > [<c0101115>] cpu_idle+0x75/0x110
> > > > [<c04f5988>] start_kernel+0x158/0x180
> > > > [<c04f5390>] unknown_bootoption+0x0/0x1e0
> > > It doesn't trouble to me. It's in idle thread.
> > 
> > You mean it does not happen to you? On my machine it fills logs very
> > quickly...
> What I mean is idle thread can't be migrated so this doesn't impact the
> correctness. I guess the preemptible debugging can't recognise such
> situation.
>

Why don't you just move that statement down, like in the patch below.
Also, if processor is not registered but idle thread managed to call
acpi_processor_idle I think it's BUG()...

I also cut out unnecessary local variable initializations.

Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>

-- 
Dmitry

===== drivers/acpi/processor.c 1.72 vs edited =====
--- 1.72/drivers/acpi/processor.c	2004-12-03 02:25:47 -05:00
+++ edited/drivers/acpi/processor.c	2005-01-10 20:58:38 -05:00
@@ -337,15 +337,11 @@
 static void
 acpi_processor_idle (void)
 {
-	struct acpi_processor	*pr = NULL;
-	struct acpi_processor_cx *cx = NULL;
-	unsigned int			next_state = 0;
-	unsigned int		sleep_ticks = 0;
-	u32			t1, t2 = 0;
-
-	pr = processors[smp_processor_id()];
-	if (!pr)
-		return;
+	struct acpi_processor	*pr;
+	struct acpi_processor_cx *cx;
+	unsigned int		next_state;
+	unsigned int		sleep_ticks;
+	u32			t1, t2;
 
 	/*
 	 * Interrupts must be disabled during bus mastering calculations and
@@ -361,6 +357,10 @@
 		local_irq_enable();
 		return;
 	}
+
+	pr = processors[smp_processor_id()];
+	if (!pr)
+		BUG();
 
 	cx = &(pr->power.states[pr->power.state]);
 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
