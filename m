From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: problem with suspension
Date: Fri, 18 Feb 2005 13:40:35 +0100
Message-ID: <20050218124035.GB1523@elf.ucw.cz>
References: <web-47803451@infinito.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <web-47803451-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: pj.harvey-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

>    I have a problem with suspension.
> When I do
> 
>  echo disk > /sys/power/state
> 
> I have a problem with modules of SCSI controller, aic7xxx.
> I've tryed to remove the modules with
> 
>   modprobe -r aic7xxx
> 
> but the kernel was in panic. The message is
> 
>   Kernel Panic - Not syncing: Loop 1
> 
> If I don't load the module aic7xxx and I try to do the 
> suspension, all is ok.
> 
> What I do?

Fix aic7xxx so that it rmmods cleanly as a first step?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
