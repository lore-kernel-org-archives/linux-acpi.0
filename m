From: Nik Trevallyn-Jones <nik-DjZbVUabzA+jF4gvJNWmbtHuzzzSOjJt@public.gmane.org>
Subject: Re: Ceased working on Dell D600 after update to 2.6.12
Date: Tue, 20 Sep 2005 11:44:55 +1000
Message-ID: <432F6997.5040605@babel.homelinux.net>
References: <20050919143430.0AB928841D@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050919143430.0AB928841D-MRDXTZLjjMs+bN4EscsFoaQD96bmaF075NbjCUgZEJk@public.gmane.org>
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

Hi All,

Just a follow-up to let the list know how I got on.

In summary, I now have suspend to memory working to a (currently) 
acceptable degree :o)

Based on responses from Ow (thanks), I figured that either my /etc/acpi 
files had been overwritten, or the previous kernel was using different 
files. So I copied the sample.conf file, and added an entry to it:

/etc/acpi/events/xxx.conf

====================================================

# This is the config file for xxx

event=button/power.*
action=/sbin/shutdown -h now

event=button/lid.*
action=echo mem > /sys/power/state

=====================================================

**BTW: Can anyone tell me the button regexp for Fn-Esc (suspend) on my D600?


After restarting acpid, the lid button now does a suspend (which looks 
pretty similar to what I used to get with the old kernel, although there 
seem to be a few new warnings or errors in there).

Releaseing the lid button results in a resume (seems quite a bit faster 
than with the previous kernel), accompanied with this warning/error:

Message from syslogd@xxx at Tue Sep 20 10:21:05 2005 ...
xxx kernel: Disabling IRQ #5

I'm not quite sure what problems (if any) this has caused. The log shows 
that my ipw2200 failed to re-initialise, and it seems there may be 
issues with the sound driver. I've got a few messages in the logs to try 
to understand before I ask for any more help.


Once again, thank you for all your help. Once I've sorted this, I'll 
look at Suspend2.

Cheers!
Nik.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
