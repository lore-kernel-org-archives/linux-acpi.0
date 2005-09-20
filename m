From: Nik Trevallyn-Jones <nik-DjZbVUabzA+jF4gvJNWmbtHuzzzSOjJt@public.gmane.org>
Subject: Re: Ceased working on Dell D600 after update to 2.6.12
Date: Tue, 20 Sep 2005 10:58:59 +1000
Message-ID: <432F5ED3.3070305@babel.homelinux.net>
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

> Subject: Re: [ACPI] Ceased working on Dell D600 after update to 2.6.12
> From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
> Date: Mon, 19 Sep 2005 18:22:53 +0800

Hi Ow,

Thanks for you quick reply! :o)

I've answered your points below. In addition, I've made some changes to 
a conf file in /etc/acpi. I'll post details of that in a separate post.

> On Mon, 2005-09-19 at 16:19 +1000, Nik Trevallyn-Jones wrote:
> 
>>Hi All,
>>
>>This is not a complaint - I'm just looking for information. Suspend no 
>>longer works, and I really miss it!
> 
> 
> which version of suspend? Suspend2 or swsusp?
> 

*embarrassed look*  I don't really know. In the Klaptop applet menu, I 
just selected "suspend". The three options I had were:

"standby", "suspend", "hibernate"

The only one that worked for me was "suspend". I don't really know the 
difference between "standby" and "suspend", but hibernate involved 
writing to disk, and the other two didn't. (I had to disable 
mDNSResponder to get suspend working, if that's useful.)

>>/proc/acpi is populated with files and directories, and they seem to 
>>reflect the values that I configured with klaptop before it stopped working.
> 
> 
> So.. the kernel is compiled with ACPI enabled.

ok...

>>Sep 18 17:30:25 xxx acpid: acpid shutdown succeeded
> 
> 
> Does it recognise any keys?? eg: Fn-Esc, Lid, Power Button etc?

Um, if I press and hold the power button, the OS does a shutdown, so I 
guess that means its recognising the power button.

Pressing the lid button has no effect, and neither does Fn-Esc.

>>Q1: Does anyone else with a D600 on 2.6.12 on FC3 have suspend or 
>>hibernate working?
> 
> 
> I have a D600 but not running FC. I run Gentoo. I suggest, if not done
> already, try suspend2. You can see how to get it down by reading this
> article in Ed1 of the MyOSS Magazine - http://mag.my-opensource.org

Excellent!  Many, many thanks!

>>Q3: I used YUM to update the kernel - would that have caused my working 
>>ACPI config to be overwritten?
> 
> 
> Nope. Only thing is there may be new version of acpi in the new kernel.
> it will not overwrite your acpid configs. (unless you upgraded to a new
> acpid and then subsequently used the default config files. But I think
> not)

There were no packages with "acp" in their name in the YUM update. I am 
presuming that a new acpid would have "acp" somewhere in the package name?

> 
> check /etc/acpi/

That's sort of why I asked. I don't know what the contents of /etc/acpi 
were with the old kernel, because everything worked using the GUI tool.

All that's in there now is this /etc/acpi/events/sample.conf:

=============================================
# This is a sample ACPID configuration

event=button/power.*
action=/sbin/shutdown -h now

=============================================

>>Q4: Are there any HOWTOs or trouble-shooting guides to get me started?
> 
> 
> Ah.. Read Q1 and go to Suspend2.
> 
> Hibernates (to disk) in 40 secs with 1.5GB Ram.
> 
> Suspend to Ram doesn't work on my machine. Does yours? (previously?)

Absolutely. I loved it. Just close the lid, and the machine was good to 
go in 5-10 seconds. Of course, it drained the battery after some days 
(i'm seeing posts in this list on how to hopefully improve that).

Once again, thanks for your help.


Cheers!
Nik


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
