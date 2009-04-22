From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH] ACPI: delete obsolete "bus master activity" proc field
Date: Wed, 22 Apr 2009 19:53:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221951550.21119@localhost.localdomain>
References: <Pine.LNX.4.44L0.0904221050110.3405-100000@iolanthe.rowland.org>
 <200904221936.38942.oliver@neukum.org>
 <alpine.LFD.2.00.0904221848380.21119@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <alpine.LFD.2.00.0904221848380.21119-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.smoczyk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, imrehg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

The legacy ACPI idle handler was deleted from 2.6.29
leaving the CPU_IDLE idle handler, which never sets bm_activity.

So delete this unused field -- it is mis-leading to have it print
all zeros when, in fact, there may bus master activity
occurring -- just that we don't track its history any more.

This patch could break something that parses
/proc/acpi/processor/*/power, since it deletes this
line from that file:

bus master activity:     00000000

Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/processor_idle.c |    4 +---
 include/acpi/processor.h      |    1 -
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9d1f01e..eed3b45 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -662,11 +662,9 @@ static int acpi_processor_power_seq_show(struct seq_file *seq, void *offset)
 
 	seq_printf(seq, "active state:            C%zd\n"
 		   "max_cstate:              C%d\n"
-		   "bus master activity:     %08x\n"
 		   "maximum allowed latency: %d usec\n",
 		   pr->power.state ? pr->power.state - pr->power.states : 0,
-		   max_cstate, (unsigned)pr->power.bm_activity,
-		   pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY));
+		   max_cstate, pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY));
 
 	seq_puts(seq, "states:\n");
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index b09c4fd..4927c06 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -84,7 +84,6 @@ struct acpi_processor_power {
 	struct acpi_processor_cx *state;
 	unsigned long bm_check_timestamp;
 	u32 default_state;
-	u32 bm_activity;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 	int timer_broadcast_on_state;
-- 
1.6.3.rc1.34.g0be9b


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
