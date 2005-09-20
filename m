From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Ceased working on Dell D600 after update to 2.6.12
Date: Tue, 20 Sep 2005 10:01:54 +0800
Message-ID: <1127181714.25800.45.camel@neuromancer.home.net>
References: <20050919143430.0AB928841D@sc8-sf-spam1.sourceforge.net>
	 <432F6997.5040605@babel.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <432F6997.5040605-DjZbVUabzA+jF4gvJNWmbtHuzzzSOjJt@public.gmane.org>
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

On Tue, 2005-09-20 at 11:44 +1000, Nik Trevallyn-Jones wrote:

> /etc/acpi/events/xxx.conf
> 
> ====================================================
> event=button/lid.*
> action=echo mem > /sys/power/state
> =====================================================
> 
> **BTW: Can anyone tell me the button regexp for Fn-Esc (suspend) on my D600?

I use perl.

 
        if ($first_arg =~ /^button\/sleep$/) {
                shift (@ARGV);
                system ('/usr/sbin/hibernate --force');


Try tailing the log file :-)

 received event "button/sleep SBTN 00000080 00000002"
[Tue Sep 13 22:02:31 2005] notifying client 12488[500:100]
[Tue Sep 13 22:02:31 2005] executing action "/etc/acpi/handle.pl
button/sleep SBTN 00000080 00000002"




> Message from syslogd@xxx at Tue Sep 20 10:21:05 2005 ...
> xxx kernel: Disabling IRQ #5
> 
> I'm not quite sure what problems (if any) this has caused. The log shows 
> that my ipw2200 failed to re-initialise, and it seems there may be 
> issues with the sound driver. I've got a few messages in the logs to try 
> to understand before I ask for any more help.

ipw2200 will need to be rmmod from the kernel. Along with some other
"blacklists".

You can search for suspend2's hibernate script, it supports in-kernel
swsusp too.

*  sys-power/hibernate-script
      Latest version available: 1.10-r1
      Latest version installed: 1.10
      Size of downloaded files: 62 kB
      Homepage:    http://www.suspend2.net
      Description: Hibernate script supporting multiple suspend methods
      License:     GPL-2

> 
> 
> Once again, thank you for all your help. Once I've sorted this, I'll 
> look at Suspend2.

Better yet, look now!! There's even a kernel packaged for FC Folks. See
the article for the link to the packager's homepage etc.

-- 
Ow Mun Heng
Gentoo/Linux on DELL D600 1.4Ghz 1.5GB RAM
98% Microsoft(tm) Free!! 
Neuromancer 10:01:54 up 1 day, 19 min, 7 users, load average: 2.22,
2.31, 2.28 




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
