From: Ferenc Szalma <szalmaf-JAjqph6Yjy97jm546uhsrg@public.gmane.org>
Subject: Re: swsusp: FATAL: cannot find swap device, try swapon -a!
Date: Wed, 23 Mar 2005 21:12:59 -0500 (EST)
Message-ID: <Pine.GSO.4.61.0503232104010.29583@z.glue.umd.edu>
References: <Pine.GSO.4.61.0503231901190.15962@z.glue.umd.edu>
 <1111626849.14853.324.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
In-Reply-To: <1111626849.14853.324.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Thu, 24 Mar 2005, Nigel Cunningham wrote:

> Pavel's:  resume=/dev/hda3
> Suspend2: resume2=swap:/dev/hda3 (or just resume2=/dev/hda3 if swap is
> the only writer)
>
> If you remove the "swap:", you should be a bit closer to being in
> business.

Thanks a lot. Removing "swap:" has helped (after spending the whole last 
weekend trying to install swsusp2 with 5 different kernels ... etc.)

Now I just do not understand why suspend-to-ram does not work. It 
apparently suspends, and then turning the machine on again, it just boots 
up as if it had not been suspended, except that it has to repair the 
file system. If anybody has an idea about this, it would be appreciated.

Thanks, Ferenc


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
