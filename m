From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Driver Testing
Date: Thu, 24 Mar 2005 11:29:10 +0100
Message-ID: <20050324102910.GA1635@elf.ucw.cz>
References: <20050317012151.36290.qmail@web31406.mail.mud.yahoo.com> <1111064539.8136.165.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111064539.8136.165.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Folks,
> >   I am adding power management support to a network
> > driver on Linux 2.6. I have a simple question, is
> > there a tool I can use to test my PM support?
> > Something that will put my PC (Dell Optiplex) to sleep
> > and wakes it up after say 1-minute?
> 
> cd /sys/class/net/(whatever)/device/power
> 
> To suspend that device:
> 
> echo -n 3 >state
> 
> To resume it:
> 
> echo -n 0 >state
> 
> That doesn't necessarily check that you've got interrupt handling code
> right, but it's a good start.

I'm surprised this even works ;-).

echo reboot > /sys/power/disk, then do echo disk > /sys/power/state in
a loop...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
