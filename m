From: Jose Celestino <japc@co.sapo.pt>
Subject: Re: Re: Re: [announce] Intel announces the PowerTOP utility for
	Linux
Date: Sat, 12 May 2007 05:09:31 +0100
Message-ID: <20070512040930.GC6464@co.sapo.pt>
References: <4644F726.1050806@linux.intel.com> <20070512001718.GY11166@waste.org> <20070512014052.GA4082@co.sapo.pt> <20070512023904.GY11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:48218 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752854AbXELEJ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2007 00:09:28 -0400
Content-Disposition: inline
In-Reply-To: <20070512023904.GY11115@waste.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Words by Matt Mackall [Fri, May 11, 2007 at 09:39:05PM -0500]:
> On Sat, May 12, 2007 at 02:40:52AM +0100, Jose Celestino wrote:
> > Words by Matt Mackall [Fri, May 11, 2007 at 07:17:19PM -0500]:
> > > On Fri, May 11, 2007 at 04:07:18PM -0700, Arjan van de Ven wrote:
> > > > 
> > > > What's eating the battery life of my laptop? Why isn't it many more 
> > > > hours? Which software component causes the most power to be burned? 
> > > > These are important questions without a good answer... until now.
> > > 
> > > I get:
> > > 
> > > No detailed statistics available; please enable the CONFIG_TIMER_STATS
> > > kernel option
> > > 
> > 
> > Must run as root (rw to /proc/timer_stats is needed).
> 
> That file doesn't exist, despite CONFIG_TIMER_STATS being in
> /proc/config.gz.
> 

Then again, perhaps you have /proc/tstats instead.

If so apply this (well, you get the idea):

--- powertop/powertop.c 2007-05-12 05:01:15.000000000 +0100
+++ powertop_new/powertop.c     2007-05-12 05:08:46.000000000 +0100
@@ -212,8 +212,8 @@
 void stop_timerstats(void)
 {
        FILE *file;
-       file = fopen("/proc/timer_stats","w");
-       if (!file) {
+       if (!(file = fopen("/proc/timer_stats","w")) &&
+               !(file = fopen("/proc/stats","w")) ) {
                nostats = 1;
                return;
        }
@@ -223,8 +223,8 @@
 void start_timerstats(void)
 {
        FILE *file;
-       file = fopen("/proc/timer_stats","w");
-       if (!file) {
+       if (!(file = fopen("/proc/timer_stats","w")) &&
+               !(file = fopen("/proc/stats","w")) ) {
                nostats = 1;
                return;
        }
@@ -388,7 +388,7 @@
                i = 0;
                totalticks = 0;
                if (!nostats)
-                       file = popen("cat /proc/timer_stats | sort -n | tail -190", "r");
+                       file = popen("cat /proc/timer_stats 2>>/dev/null|| cat /proc/tstats | sort -n | tail -190", "r");
                while (file && !feof(file) && i<190) {
                        char *count, *pid, *process, *func;
                        int cnt;


-- 
Jose Celestino
----------------------------------------------------------------
http://www.msversus.org/     ; http://techp.org/petition/show/1
http://www.vinc17.org/noswpat.en.html
----------------------------------------------------------------
"And on the trillionth day, Man created Gods." -- Thomas D. Pate
