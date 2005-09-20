From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Ceased working on Dell D600 after update to 2.6.12
Date: Tue, 20 Sep 2005 09:57:11 +0800
Message-ID: <1127181431.25800.40.camel@neuromancer.home.net>
References: <20050919143430.0AB928841D@sc8-sf-spam1.sourceforge.net>
	 <432F5ED3.3070305@babel.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <432F5ED3.3070305-DjZbVUabzA+jF4gvJNWmbtHuzzzSOjJt@public.gmane.org>
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

On Tue, 2005-09-20 at 10:58 +1000, Nik Trevallyn-Jones wrote:
> > Subject: Re: [ACPI] Ceased working on Dell D600 after update to 2.6.12
> > From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
> > Date: Mon, 19 Sep 2005 18:22:53 +0800
> 
> Hi Ow,
> 
> Thanks for you quick reply! :o)
:-0


> > which version of suspend? Suspend2 or swsusp?
> > 
> 
> *embarrassed look*  I don't really know. In the Klaptop applet menu, I 
> just selected "suspend". The three options I had were:

Sorry.. what distro are you running? It's safe to say that unless you
did anything special with your laptop, its running on swsusp and not
suspend2.

> . (I had to disable 
> mDNSResponder to get suspend working, if that's useful.)

not useful :-) But I believe this is FC then.

> > Does it recognise any keys?? eg: Fn-Esc, Lid, Power Button etc?
> 
> Um, if I press and hold the power button, the OS does a shutdown, so I 
> guess that means its recognising the power button.
> 
> Pressing the lid button has no effect, and neither does Fn-Esc.

That may be because it's not looking or triggering any rules. Check 

$ sudo tail -f /var/log/acpid 

and press the buttons, You will see things like

[Tue Sep 13 20:44:54 2005] received event "button/lid LID 00000080
00000009"
[Tue Sep 13 20:44:54 2005] executing action "/etc/acpi/handle.pl
button/lid LID 00000080 00000009

> > already, try suspend2. You can see how to get it down by reading this
> > article in Ed1 of the MyOSS Magazine - http://mag.my-opensource.org
> 
> Excellent!  Many, many thanks!

No Probs.

> 
> > 
> > check /etc/acpi/
> 
> That's sort of why I asked. I don't know what the contents of /etc/acpi 
> were with the old kernel, because everything worked using the GUI tool.
> 
> All that's in there now is this /etc/acpi/events/sample.conf:
> 
> =============================================
> # This is a sample ACPID configuration
> 
> event=button/power.*
> action=/sbin/shutdown -h now
> 
> =============================================


That's why it didn't recognise anything else.

Try this
event=button[ /]lid
action=/usr/X11R6/bin/xset -display :0 dpms force off

(I use the lid button to turn off the display. Suspend to ram not
working for me :-( )



> > Hibernates (to disk) in 40 secs with 1.5GB Ram.
> > 
> > Suspend to Ram doesn't work on my machine. Does yours? (previously?)
> 
> Absolutely. I loved it. Just close the lid, and the machine was good to 
> go in 5-10 seconds. Of course, it drained the battery after some days 
> (i'm seeing posts in this list on how to hopefully improve that).

I feel so left out :-)

-- 
Ow Mun Heng
Gentoo/Linux on DELL D600 1.4Ghz 1.5GB RAM
98% Microsoft(tm) Free!! 
Neuromancer 09:54:28 up 1 day, 12 min, 7 users, load average: 2.20,
2.23, 2.25 




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
