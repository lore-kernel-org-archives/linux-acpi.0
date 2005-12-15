From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: unable to set alam using echo to /proc/acpi/alarm
Date: Thu, 15 Dec 2005 17:23:46 +0100
Message-ID: <20051215162346.GI2904@elf.ucw.cz>
References: <59D45D057E9702469E5775CBB56411F1011BD8A4@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59D45D057E9702469E5775CBB56411F1011BD8A4@pdsmsx406>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ronald Wielink <ronald.mythtv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>    when I try setting the alarm to wake up my pc I get the following
> >>    result:
> >>    [root@mithrandir acpi]# pwd
> >>    /proc/acpi
> >>    [root@mithrandir acpi]# cat alarm
> >>    2005-12-00 00:00:00
> >>    [root@mithrandir acpi]# echo 2005-12-15 17:18:19 > alarm
> >>    [root@mithrandir acpi]# cat alarm
> >>    2005-12-00 17:18:19
> >>    [root@mithrandir acpi]#
> >>    BTW, nothing happens at the echo'd date/time. Could someone please
> >>    give me a clue where to start looking?  I'm running fedora core 4,
> my
> >>    mobo is an ASUS P5S800-VM, the documentation on the motherboard
> states
> >>    that ACPI is supported. There is an option to turn acpi 2.0 on,
> but no
> >>    difference...
> >
> >alarm never worked properly, IIRC.

> It works well on different systems here :).

Okay, so the problem is in me. Could we get some documentation? It
would be useful to know what to expect, and it should probably end up
in Documentation/ somewhere.
								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
