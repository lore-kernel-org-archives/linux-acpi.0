From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Help wanted with IRQ routing.
Date: Fri, 18 Feb 2005 09:10:38 +1100
Message-ID: <1108678238.28503.1.camel@desktop.cunningham.myip.net.au>
References: <1108371574.12611.61.camel@desktop.cunningham.myip.net.au>
	 <1108398282.4208.10.camel@eeyore>
	 <1108419552.12611.98.camel@desktop.cunningham.myip.net.au>
	 <1108570493.20278.9.camel@eeyore>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108570493.20278.9.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi again Bjorn.

On Thu, 2005-02-17 at 03:14, Bjorn Helgaas wrote:
> On Tue, 2005-02-15 at 09:19 +1100, Nigel Cunningham wrote:
> > > Did you try booting with "pci=routeirq" or turning off PNPACPI?
> > > I've seen a few reports of IRQ problems with PCMCIA devices that
> > > seemed to be related to one or both of these.
> > 
> > I tried pci=routeirq and it didn't make a difference. I assume PNPACPI
> > is the ACPI Hotplug driver? If so, it didn't help either. It if helps at
> > all, this is an Omnibook XE3-GF (4304 flavour).
> 
> Actually, PNPACPI is a build-time config option.  If your kernel
> is new enough, you can also turn it off at boot-time with
> "pnpacpi=off".

Okay. I booted 2.6.11-rc4 with the option, but no difference, I'm
afraid. Is there anyway I can force it to use a different IRQ? I'll
happily try ugly setpci commands :>

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
