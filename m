From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: suspend-to-disk: fan always on and misc kernel
	errors
Date: Mon, 04 Apr 2005 18:03:02 +1000
Message-ID: <1112601782.3757.9.camel@desktop.cunningham.myip.net.au>
References: <4246F06D.40005@cs.unibo.it>
	 <20050328205027.GB28568@message-id.gmane0305.slipkontur.de>
	 <4249A359.9060301@cs.unibo.it>
	 <20050401221940.GC1868@message-id.gmane0305.slipkontur.de>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050401221940.GC1868-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Sat, 2005-04-02 at 08:19, Stefan Seyfried wrote:
> On Tue, Mar 29, 2005 at 08:50:01PM +0200, Andrea Borgia wrote:
> > Stefan Seyfried wrote:
> > 
> > Thanks, I have no idea how they got in the script, that partially fixed
> > it: no more "command not found" errors, but the kernel messages about
> > "scheduling while atomic" are still there and the script still aborts
> > with SIG11 after resuming from suspend.
> 
> | Mar 27 18:49:57 localhost kernel: note: swsusp-script[3902] exited with preempt_count 1
> 
> disable preempt.

Isn't that just dealing with the symptom, rather than the problem
though? Presumably something a preempt_enable() or such like is missing
somewhere.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
