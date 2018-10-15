From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] ACPICA: Fix dispatcher timeout mechanism
Date: Mon, 15 Oct 2018 16:01:35 -0700
Message-ID: <1539644495.129692.8.camel@acm.org>
References: <20181015221848.256323-1-bvanassche@acm.org>
         <CAJZ5v0jDv3ufH+MOXmrygHkBgu4CgT6DZL38xq1ViGiju8VxqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jDv3ufH+MOXmrygHkBgu4CgT6DZL38xq1ViGiju8VxqQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, kbuild test robot <fengguang.wu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Stable <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2018-10-16 at 00:44 +-0200, Rafael J. Wysocki wrote:
+AD4 On Tue, Oct 16, 2018 at 12:19 AM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 This patch avoids that the following warning is reported during hibernation:
+AD4 
+AD4 Well, what exactly is the problem and why is the patch the right way
+AD4 to address it?

It is not safe to call ktime+AF8-get() after having called timekeeping+AF8-suspend().

+AD4 +AD4  /+ACo
+AD4 +AD4 diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
+AD4 +AD4 index 0da96268deb5..9dbea4549484 100644
+AD4 +AD4 --- a/drivers/acpi/acpica/dscontrol.c
+AD4 +AD4 +-+-+- b/drivers/acpi/acpica/dscontrol.c
+AD4 +AD4 +AEAAQA -84,8 +-84,8 +AEAAQA acpi+AF8-ds+AF8-exec+AF8-begin+AF8-control+AF8-op(struct acpi+AF8-walk+AF8-state +ACo-walk+AF8-state,
+AD4 +AD4                 control+AF8-state-+AD4-control.package+AF8-end +AD0
+AD4 +AD4                     walk+AF8-state-+AD4-parser+AF8-state.pkg+AF8-end+ADs
+AD4 +AD4                 control+AF8-state-+AD4-control.opcode +AD0 op-+AD4-common.aml+AF8-opcode+ADs
+AD4 +AD4 -               control+AF8-state-+AD4-control.loop+AF8-timeout +AD0 acpi+AF8-os+AF8-get+AF8-timer() +-
+AD4 +AD4 -                   (u64)(acpi+AF8-gbl+AF8-max+AF8-loop+AF8-iterations +ACo ACPI+AF8-100NSEC+AF8-PER+AF8-SEC)+ADs
+AD4 +AD4 +-               control+AF8-state-+AD4-control.loop+AF8-timeout +AD0 jiffies +-
+AD4 +AD4 +-                   acpi+AF8-gbl+AF8-max+AF8-loop+AF8-iterations +ACo HZ+ADs
+AD4 
+AD4 jiffies is Linux-specific and so it should not be used in the ACPICA code.

Really? There is plenty of other ACPI code that uses the jiffies counter directly.
Why wouldn't it be allowed to use the jiffies counter in this context since there
is so much other ACPI code that uses that counter?

+ACQ git grep -nHw jiffies drivers/acpi
drivers/acpi/acpi+AF8-pad.c:158:		if (time+AF8-before(expire+AF8-time, jiffies)) +AHs
drivers/acpi/acpi+AF8-pad.c:159:			last+AF8-jiffies +AD0 jiffies+ADs
drivers/acpi/acpi+AF8-pad.c:165:		expire+AF8-time +AD0 jiffies +- HZ +ACo (100 - idle+AF8-pct) / 100+ADs
drivers/acpi/acpi+AF8-pad.c:184:			if (time+AF8-before(expire+AF8-time, jiffies)) +AHs
drivers/acpi/apei/ghes.c:744:	expire +AD0 jiffies +- msecs+AF8-to+AF8-jiffies(g-+AD4-notify.poll+AF8-interval)+ADs
drivers/acpi/battery.c:29:+ACM-include +ADw-linux/jiffies.h+AD4
drivers/acpi/battery.c:567:	    time+AF8-before(jiffies, battery-+AD4-update+AF8-time +-
drivers/acpi/battery.c:583:	battery-+AD4-update+AF8-time +AD0 jiffies+ADs
drivers/acpi/dock.c:30:+ACM-include +ADw-linux/jiffies.h+AD4
drivers/acpi/dock.c:365:	ds-+AD4-last+AF8-dock+AF8-time +AD0 jiffies+ADs
drivers/acpi/dock.c:389:	    time+AF8-before(jiffies, (ds-+AD4-last+AF8-dock+AF8-time +- HZ)))
drivers/acpi/dock.c:621:	dock+AF8-station-+AD4-last+AF8-dock+AF8-time +AD0 jiffies - HZ+ADs
drivers/acpi/ec.c:304:	ec-+AD4-timestamp +AD0 jiffies+ADs
drivers/acpi/ec.c:313:	ec-+AD4-timestamp +AD0 jiffies+ADs
drivers/acpi/ec.c:320:	ec-+AD4-timestamp +AD0 jiffies+ADs
drivers/acpi/ec.c:752:	+AH0 while (time+AF8-before(jiffies, timeout))+ADs
drivers/acpi/ec.c:762:		unsigned long delay +AD0 jiffies +-
drivers/acpi/ec.c:770:		+AH0 while (time+AF8-before(jiffies, delay))+ADs
drivers/acpi/ec.c:1350:	ec-+AD4-timestamp +AD0 jiffies+ADs
drivers/acpi/osl.c:41:+ACM-include +ADw-linux/jiffies.h+AD4
drivers/acpi/osl.c:1230:	long jiffies+ADs
drivers/acpi/osl.c:1246:		jiffies +AD0 MAX+AF8-SCHEDULE+AF8-TIMEOUT+ADs
drivers/acpi/osl.c:1248:		jiffies +AD0 msecs+AF8-to+AF8-jiffies(timeout)+ADs
drivers/acpi/osl.c:1250:	ret +AD0 down+AF8-timeout(sem, jiffies)+ADs
drivers/acpi/sbs.c:31:+ACM-include +ADw-linux/jiffies.h+AD4
drivers/acpi/sbs.c:377:	    time+AF8-before(jiffies, battery-+AD4-update+AF8-time +-
drivers/acpi/sbs.c:391:	battery-+AD4-update+AF8-time +AD0 jiffies+ADs
drivers/acpi/thermal.c:36:+ACM-include +ADw-linux/jiffies.h+AD4

Bart.
