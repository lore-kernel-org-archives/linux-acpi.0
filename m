From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Re: S3 suspend and serial console
Date: Tue, 08 Feb 2005 09:04:24 +1100
Message-ID: <1107813864.2756.1.camel@desktop.cunninghams>
References: <42023083.8030508@gmx.net> <4204CA50.8090906@gmx.net>
	 <20050205155845.GA20131@hell.org.pl>
	 <20050205220619.GA30739@message-id.gmane0305.slipkontur.de>
	 <4206CF63.2090600@gmx.net> <20050207141655.GB8040@elf.ucw.cz>
	 <42077B07.5090606@gmx.net> <20050207143242.GE8040@elf.ucw.cz>
	 <4207A211.3000305@gmx.net>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4207A211.3000305-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Tue, 2005-02-08 at 04:14, Carl-Daniel Hailfinger wrote:
> Pavel Machek schrieb:
> > Hi!
> > 
> > 
> >>>>Erm... is it intentional that serial powermanagement code is never
> >>>>called on entering/leaving S3? When I added debugging statements
> >>
> >>>Probably noone was yet trying to use serial during suspend....
> >>
> >>You mean noone uses the serial console while testing suspend?
> >>What is the new way to debug suspend problems not requiring a
> >>serial console?
> > 
> > Well, when video works, you debug using video. I used hardware
> > debugger, too...
> 
> Will there be any patch to actually use the powermanagement code
> in the serial core?
> 
> 
> Regarding the original problem:
> It seems the following call is sufficient to make the console work
> again. However, I haven't found a function which would give me
> the parameters needed to call ->set_termios.
> 
> serial/8250.c: serial8250_set_termios
> 
> Do you have any idea how to obtain the termios and tty structures
> for a given port, e.g. ttyS0?

We have code for 2.4 in Suspend2. I haven't seen any need for it in 2.6;
it just works (except that you can't send keystrokes early in the boot
process). Haven't tried S3, so I don't know the issues there.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
