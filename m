From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: PNP device interrupt type?
Date: Thu, 22 Sep 2005 08:55:51 +0800
Message-ID: <1127350552.3961.11.camel@linux-hp.sh.intel.com>
References: <200509210916.51581.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509210916.51581.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
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
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Krzysztof Oledzki <olel-gcSpNFQc7Gg@public.gmane.org>, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
Sorry, I wrongly cc-ed the maillist address in previous email.

On Wed, 2005-09-21 at 23:16 +0800, Bjorn Helgaas wrote:
> On Wednesday 21 September 2005 8:59 am, Krzysztof Oledzki wrote: 
> > On Wed, 21 Sep 2005, Bjorn Helgaas wrote: 
> >  
> > > On Tuesday 20 September 2005 7:32 pm, Li, Shaohua wrote: 
> > >> Is it possible PNP devices use level trigger interrupt? 
> > >> IIRC, PNP devices always use edge trigger interrupt under x86, 
> > >> how about the IA64 case? 
> > > 
> > > I'm not aware of any reason why ACPI devices should always 
> > > be edge triggered on ia64. 
> > > 
> > >> If PNP devices always use edge trigger 
> > >> interrupt, 
> > >> we might ignore BIOS setting. 
> > >> We have a bug BIOS assign wrong interrupt info to RTC 
> > >> http://bugzilla.kernel.org/show_bug.cgi?id=5243 
> > > 
> > > ACPI can describe any combination of edge/level, high/low, 
> > > so I think it would be a bad idea to throw away the information 
> > > the firmware is giving us. 
> > > 
> > > We might have to figure out ways to work around firmware 
> > > defects.  But that seems better to me than just ignoring 
> > > what the firmware tells us.  That will lead to situations 
> > > where the hardware and firmware are perfectly legal and 
> > > correct, but Linux doesn't work (i.e., the hardware uses 
> > > level triggered interrupts for some device, and Linux ignores 
> > > that and treats it as edge-triggered). 
> >  
> > As far as i understand question, it was not about *ALL* ACPI devices
> but  
> > only about PNP ones.
> 
> What is the difference between a "PNP" ACPI device and a "non-PNP" 
> ACPI device?  It looks to me like PNPACPI will expose all ACPI 
> devices as PNP devices (with a couple exceptions, like things that 
> don't have any _CRS method).
> 
> > And IMO the real problem is only RTC on x86 so the   
> > workaround can only force this type of interrupt.
> 
> Any workaround should be applied as narrowly as possible, to 
> minimize the chance of breaking a platform that legitimately 
> chooses to use a level-triggered interrupt.  If there's a 
> spec or convention that requires RTC to be edge-triggered 
> on x86, I don't object to reflecting that in the code somehow.
Ok, maybe we could do this workaround for x86 and report a warning.
Let's see if it breaks anything.

Thanks,
Shaohua



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
