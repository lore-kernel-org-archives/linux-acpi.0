From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH] PNPACPI: handle address descriptors in _PRS
Date: Fri, 23 Sep 2005 08:55:01 +0800
Message-ID: <1127436901.3933.0.camel@linux-hp.sh.intel.com>
References: <200509210927.03377.bjorn.helgaas@hp.com>
	 <1127350144.3961.5.camel@linux-hp.sh.intel.com>
	 <200509221748.30090.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509221748.30090.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-09-22 at 17:48 -0600, Bjorn Helgaas wrote:
> On Wednesday 21 September 2005 6:49 pm, Shaohua Li wrote:
> > On Wed, 2005-09-21 at 23:27 +0800, Bjorn Helgaas wrote:
> > > On Tuesday 20 September 2005 7:17 pm, Shaohua Li wrote: 
> > > > On Tue, 2005-09-20 at 16:26 -0600, Bjorn Helgaas wrote: 
> > > > > PNPACPI complained about and ignored devices with ADDRESS16,
> > > ADDRESS32, 
> > > > > or ADDRESS64 descriptors in _PRS.  Those descriptors seem
> > > legitimate, 
> > > > > and HP firmware uses them for built-in serial ports, so this patch
> > > adds 
> > > > > support for them.
> > > 
> > > > You might have missed the similar change in pnpacpi_encode_resources
> > > in 
> > > > your patch. It's used when we assign new resources (_SRS method) to
> > > pnp 
> > > > devices.
> > > 
> > > You're right, I did miss the corresponding encoding change.  I'll 
> > > add that.  I feel a bit uneasy about it, though, because it will be 
> > > a fair amount of code, and I don't know how to test it.  Do we ever 
> > > really use _SRS today?  And there's information lost when decoding 
> > > the ACPI resources, such as the _TRA.
> > We did use _SRS, at least under x86. This only is done when some PNP
> > devices havn't resources, so only very small number of systems need it.
> > Ignoring it might be ok currently, if HP firmware always assigns
> > resources to PNP devices. Yes, we did lose the info of _TRA. I didn't
> > find any system uses it. Maybe some big IA64 systems use.
> 
> HP ia64 systems definitely use _TRA.  I would expect most systems
> with multiple PCI root bridges would use _TRA, because if you
> don't, the amount of 32-bit PCI bus address space you can use
> is severely limited.
> 
> HP firmware does assign resources to the PNP devices (typically
> they're things hardwired onto the motherboard at fixed addresses).
> So we don't actually need the encoding changes at the moment.
> 
> I'm inclined to just leave the encoding out for now.  That
> way, we don't carry around the untested code, and if somebody
> eventually tries to use it, the attempt to set resources will
> fail, and we can write the code and test it at that time.
Ok, lets wait till it actually is used.

Thanks,
Shaohua



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
