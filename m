From: Fischer Tibor <fishy-RTHRExztqpST9ig0jae3mg@public.gmane.org>
Subject: Re: Asus m6n mail LED
Date: Thu, 02 Sep 2004 21:21:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <413772C1.9080405@freemind.hu>
References: <413614EE.4000802@freemind.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <413614EE.4000802-RTHRExztqpST9ig0jae3mg@public.gmane.org>
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

hi,

i made it work, so if someone interested here is the solution.
it works with other types too
i made a file /root/mailcheck.sh with content:
#!/bin/bash
old=$(cat /tmp/size)
new=$(du -s /home/fishy/.thunderbird/default/sgzo838b.slt/Mail | cut -f 1)

du -s /home/fishy/.thunderbird/default/sgzo838b.slt/Mail |cut -f 1 
 >/tmp/size
if [ "$old" == "$new" ]; then
       echo 0 >/proc/acpi/asus/mled
else
       echo 1 >/proc/acpi/asus/mled
fi


and put */2 * * * * /root/mailcheck.sh into /etc/crontab
crontab /etc/crontab

it checks mail dir's size in 2 mins, and the led will also lighht for 2 
min's
exchange the directory names to yours

BR,
Fishy

Fischer Tibor wrote:

> Hi,
>
> i us gentoo on my asus m6800n. i would like mozilla thunderbird, to 
> turn on my mail led, when new mail arrrives, and turn it off, when i 
> made it read.
> is it possible somehow ?
>
> thx,
> Fishy
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
