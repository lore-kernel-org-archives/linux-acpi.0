From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: swsusp: FATAL: cannot find swap device, try swapon -a!
Date: Thu, 24 Mar 2005 12:14:10 +1100
Message-ID: <1111626849.14853.324.camel@desktop.cunningham.myip.net.au>
References: <Pine.GSO.4.61.0503231901190.15962@z.glue.umd.edu>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.61.0503231901190.15962@z.glue.umd.edu>
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

On Thu, 2005-03-24 at 11:09, Ferenc Szalma wrote:
> I use gentoo linux with kernel-2.6.11.4 kernel (not gentoo-kernel!) 
> patched with acpi-20050309-2.6.11.diff.gz and boot with 
> resume=swap:/dev/hda3 where hda3 is my swap patition. I have searched the 
> web and I see that I am not the 1st one getting the same error message; 

Your problem is that you have mixed up the syntax for Suspend2 and
Pavel's implementation:

Pavel's:  resume=/dev/hda3
Suspend2: resume2=swap:/dev/hda3 (or just resume2=/dev/hda3 if swap is
the only writer)

If you remove the "swap:", you should be a bit closer to being in
business.

Regards,

Nigel
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
