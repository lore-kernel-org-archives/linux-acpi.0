From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: suspend-to-disk: fan always on and misc kernel errors
Date: Sat, 2 Apr 2005 00:19:40 +0200
Message-ID: <20050401221940.GC1868@message-id.gmane0305.slipkontur.de>
References: <4246F06D.40005@cs.unibo.it> <20050328205027.GB28568@message-id.gmane0305.slipkontur.de> <4249A359.9060301@cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4249A359.9060301-iEixELS/QsY1GQ1Ptb7lUw@public.gmane.org>
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

On Tue, Mar 29, 2005 at 08:50:01PM +0200, Andrea Borgia wrote:
> Stefan Seyfried wrote:
> 
> Thanks, I have no idea how they got in the script, that partially fixed
> it: no more "command not found" errors, but the kernel messages about
> "scheduling while atomic" are still there and the script still aborts
> with SIG11 after resuming from suspend.

| Mar 27 18:49:57 localhost kernel: note: swsusp-script[3902] exited with preempt_count 1

disable preempt.
 
> Anyhow, I found out that the fan issue is related to powernowd not being
> restarted because of the script failure.
> 
> Any clues about that? I tried both platform and shutdown for disk, but
> the only difference is that platform reboots immediately instead of

interesting, but another bug...

> powering down. Also, writing "4b" to acpi/sleep is the same as "disk" to
> power/state.

known, s4bios is not working for a long time now, we should remove it.
"echo 4 > /proc/acpi/sleep" is supposed to do the same thing as "echo disk >
/sys/power/state" on an acpi system.

-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
