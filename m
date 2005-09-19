From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Ceased working on Dell D600 after update to 2.6.12
Date: Mon, 19 Sep 2005 18:22:53 +0800
Message-ID: <1127125374.20268.76.camel@neuromancer.home.net>
References: <432E5854.4060902@babel.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <432E5854.4060902-DjZbVUabzA+jF4gvJNWmbtHuzzzSOjJt@public.gmane.org>
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

On Mon, 2005-09-19 at 16:19 +1000, Nik Trevallyn-Jones wrote:
> Hi All,
> 
> This is not a complaint - I'm just looking for information. Suspend no 
> longer works, and I really miss it!

which version of suspend? Suspend2 or swsusp?

> I have just updated to kernel 2.6.12-1.1376_FC3, and cannot get ACPI 
> configured or working. If I run klaptop_acpi_helper --suspend, 
> absolutely nothing happens - not even an error message. I have tried 
> configuring ACPI with the Klaptop applet, but it just told me that the 
> helper application has the wrong permissions, regardless of how often I 
> set the permissions. Now, some reboots later, the klaptop applet fails 
> to start up (I don't even get a menu when I click on the applet icon).



> /proc/acpi is populated with files and directories, and they seem to 
> reflect the values that I configured with klaptop before it stopped working.

So.. the kernel is compiled with ACPI enabled.


> Sep 18 17:30:25 xxx acpid: acpid shutdown succeeded

Does it recognise any keys?? eg: Fn-Esc, Lid, Power Button etc?

> Q1: Does anyone else with a D600 on 2.6.12 on FC3 have suspend or 
> hibernate working?

I have a D600 but not running FC. I run Gentoo. I suggest, if not done
already, try suspend2. You can see how to get it down by reading this
article in Ed1 of the MyOSS Magazine - http://mag.my-opensource.org


> Q2: Are there known things I should do, or known issues I need to avoid 
> with this configuration?

I'm not sure. Most likely it's the new kernel.

> Q3: I used YUM to update the kernel - would that have caused my working 
> ACPI config to be overwritten?

Nope. Only thing is there may be new version of acpi in the new kernel.
it will not overwrite your acpid configs. (unless you upgraded to a new
acpid and then subsequently used the default config files. But I think
not)

check /etc/acpi/

> Q4: Are there any HOWTOs or trouble-shooting guides to get me started?

Ah.. Read Q1 and go to Suspend2.

Hibernates (to disk) in 40 secs with 1.5GB Ram.

Suspend to Ram doesn't work on my machine. Does yours? (previously?)



-- 
Ow Mun Heng
Gentoo/Linux on DELL D600 1.4Ghz 1.5GB RAM
98% Microsoft(tm) Free!! 
Neuromancer 18:17:35 up 8:35, 7 users, load average: 0.58, 1.18, 0.94 




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
