From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Help wanted with IRQ routing.
Date: Fri, 18 Feb 2005 09:23:33 -0700
Message-ID: <1108743813.25491.13.camel@eeyore>
References: <1108371574.12611.61.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108371574.12611.61.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-02-14 at 19:59 +1100, Nigel Cunningham wrote:
> While visiting the US, I purchased a Netgear 511T card for my laptop.
> It's being a pain to set up, and so I'm wanting to ask for some help.
> (For the record, I set up a 311 on my desktop machine, so I believe I
> know what I'm doing in general).
> 
> The problem I see is that when I start wpa_supplicant (ie actually start
> to use the card), everything freezes up. If I pop the card out quickly,
> I see that a couple of thousand interrupts have occurred in the couple
> of seconds. If I'm too slow, I have to restart the machine.
> 
> I've spent a fair while Googling with the result that I think my problem
> might be solved by getting the card on an interrupt line all by itself ...

Ok, let's back up.  Is there something that points to ACPI here?
What driver does the 511T use?  I'd be more inclined to suspect
a problem there.  For example, maybe the interrupt service routine
returns IRQ_NONE when it should return IRQ_HANDLED.

As far as getting the card on an interrupt by itself, it's probably
hard to do that in a laptop, except by removing the drivers for the
other devices that share the interrupt.  If you can try that, the
results would be interesting.

I'd be interested in seeing the complete dmesg log and /proc/interrupts
contents.  Not that I have any good ideas, but at least it's a concrete
place to start ;-)



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
