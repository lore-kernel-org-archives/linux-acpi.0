From: Andrea Borgia <borgia-iEixELS/QsY1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: Re: suspend-to-disk: fan always on and misc kernel errors
Date: Sun, 03 Apr 2005 13:05:00 +0200
Message-ID: <424FCDDC.2090905@cs.unibo.it>
References: <4246F06D.40005@cs.unibo.it> <20050328205027.GB28568@message-id.gmane0305.slipkontur.de> <4249A359.9060301@cs.unibo.it> <20050401221940.GC1868@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Stefan Seyfried wrote:


> | Mar 27 18:49:57 localhost kernel: note: swsusp-script[3902] exited with preempt_count 1
> disable preempt.

Thanks, that did it: now it suspends/resumes with no errors reported and 
the script runs to completion (including restarting powernowd and 
stopping the fan soon afterwards).


> known, s4bios is not working for a long time now, we should remove it.
> "echo 4 > /proc/acpi/sleep" is supposed to do the same thing as "echo disk >
> /sys/power/state" on an acpi system.

Does it make any difference which interface is used (/sys/power vs 
/proc/acpi) ?


Thanks again,
Andrea.

-- 
Homepage: http://andrea.borgia.bo.it     /    Amateur radio: IZ4FHT



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
