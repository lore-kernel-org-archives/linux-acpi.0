From: Andrea Borgia <borgia-iEixELS/QsY1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: Re: suspend-to-disk: fan always on and misc kernel errors
Date: Tue, 29 Mar 2005 20:50:01 +0200
Message-ID: <4249A359.9060301@cs.unibo.it>
References: <4246F06D.40005@cs.unibo.it> <20050328205027.GB28568@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050328205027.GB28568-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
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


>>2) script terminates with error and spews "command not found" problems 
>>only in the post-wakeup section, even though full pathnames are used 
>>(see script)
> 
> you have some funny special characters in there, no wonder bash barfs on that.

Thanks, I have no idea how they got in the script, that partially fixed
it: no more "command not found" errors, but the kernel messages about
"scheduling while atomic" are still there and the script still aborts
with SIG11 after resuming from suspend.

Anyhow, I found out that the fan issue is related to powernowd not being
restarted because of the script failure.

Any clues about that? I tried both platform and shutdown for disk, but
the only difference is that platform reboots immediately instead of
powering down. Also, writing "4b" to acpi/sleep is the same as "disk" to
power/state.

TIA,
Andrea.

-- 
Homepage: http://andrea.borgia.bo.it     /    Amateur radio: IZ4FHT



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
