From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: swsusp: FATAL: cannot find swap device, try swapon -a!
Date: Thu, 24 Mar 2005 13:23:57 +1100
Message-ID: <1111631037.14853.399.camel@desktop.cunningham.myip.net.au>
References: <Pine.GSO.4.61.0503231901190.15962@z.glue.umd.edu>
	 <1111626849.14853.324.camel@desktop.cunningham.myip.net.au>
	 <Pine.GSO.4.61.0503232104010.29583@z.glue.umd.edu>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.61.0503232104010.29583@z.glue.umd.edu>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ferenc Szalma <szalmaf-JAjqph6Yjy97jm546uhsrg@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Thu, 2005-03-24 at 13:12, Ferenc Szalma wrote:
> Hi,
> 
> On Thu, 24 Mar 2005, Nigel Cunningham wrote:
> 
> > Pavel's:  resume=/dev/hda3
> > Suspend2: resume2=swap:/dev/hda3 (or just resume2=/dev/hda3 if swap is
> > the only writer)
> >
> > If you remove the "swap:", you should be a bit closer to being in
> > business.
> 
> Thanks a lot. Removing "swap:" has helped (after spending the whole last 
> weekend trying to install swsusp2 with 5 different kernels ... etc.)

Can't help with the next bit, but I am intrigued as to what the problem
was with suspend2. If you give me details, I might be able to help.

Regards,

Nigel

> Now I just do not understand why suspend-to-ram does not work. It 
> apparently suspends, and then turning the machine on again, it just boots 
> up as if it had not been suspended, except that it has to repair the 
> file system. If anybody has an idea about this, it would be appreciated.
> 
> Thanks, Ferenc
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
