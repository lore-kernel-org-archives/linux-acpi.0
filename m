From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Help wanted with IRQ routing.
Date: Wed, 16 Feb 2005 09:14:53 -0700
Message-ID: <1108570493.20278.9.camel@eeyore>
References: <1108371574.12611.61.camel@desktop.cunningham.myip.net.au>
	 <1108398282.4208.10.camel@eeyore>
	 <1108419552.12611.98.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108419552.12611.98.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
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

On Tue, 2005-02-15 at 09:19 +1100, Nigel Cunningham wrote:
> > Did you try booting with "pci=routeirq" or turning off PNPACPI?
> > I've seen a few reports of IRQ problems with PCMCIA devices that
> > seemed to be related to one or both of these.
> 
> I tried pci=routeirq and it didn't make a difference. I assume PNPACPI
> is the ACPI Hotplug driver? If so, it didn't help either. It if helps at
> all, this is an Omnibook XE3-GF (4304 flavour).

Actually, PNPACPI is a build-time config option.  If your kernel
is new enough, you can also turn it off at boot-time with
"pnpacpi=off".



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
