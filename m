From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Multiple problems on Thinkpad A31p
Date: Sun, 05 Dec 2004 15:36:22 +0000
Message-ID: <1102260982.9384.13.camel@tyrosine>
References: <20041204124734.A22065@petamem.com>
	 <1102212367.9384.5.camel@tyrosine>  <20041205162029.A994@petamem.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041205162029.A994-SPYDw57wZyZBDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Richard Jelinek <rj-SPYDw57wZyZBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-12-05 at 16:20 +0100, Richard Jelinek wrote:

> standby, suspend & off: switch the display off completely - no backlight
> reduced: no effect
> on: switches screen on again
> 
> Don't know whether there should be more parameters, the syntax
> description doesn't end with a ']'
> 
> What do the results tell us?

Ok, that's good. In your sleep script, you probably want to do something
like:

CONSOLE=`fgconsole`
chvt 12
dpms off
echo -n mem >/sys/power/state
dpms on
chvt $CONSOLE

> > 2.6.9 has better USB power management.
> 
> Hopefully it handles then Unplug (DVD-RAM) & Plug (USB-Craddle for
> Palm) of the Ultrabay as good as the 2.4.26 did: without freezing the
> machine. ;-)

I've had no real problems with it.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
