From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Wed, 3 Nov 2004 13:41:39 +0100
Message-ID: <20041103124138.GC18867@wotan.suse.de>
References: <20041018020816.48673359@localhost.localdomain> <20041018112632.GB4400@openzaurus.ucw.cz> <20041021001331.69c6c965@localhost.localdomain> <20041020225334.GC29863@elf.ucw.cz> <20041101145410.GB12006@tate.loria.fr> <20041101154127.GB1056@elf.ucw.cz> <20041102220034.GA31435@tate.loria.fr> <20041102220958.GF1407@elf.ucw.cz> <20041103105106.GA4174@wotan.suse.de> <yzoekjbgod9.fsf@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yzoekjbgod9.fsf-vJEk5272eHo@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ole.rohne-vJEk5272eHo@public.gmane.org
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Emmanuel Thom?? <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2004 at 12:31:46PM +0100, ole.rohne-vJEk5272eHo@public.gmane.org wrote:
> Andi> Or rather not apply this. I have no plans to support switch back
> Andi> to real mode on x86-64. It is just far too hackish and fragile.
> 
> I agree that return to real mode is kind of *hackish* - but I do not
> agree that it has to be *fragile*. I'd like to repeat my general
> comments on the alternatives, not particularly connected to x86-64:

I very much doubt it you can get it reliable because it's such an 
extremly intrusive operation. 

> 
> Andi> Either do it before switching to protected/long mode or later
> Andi> in a emulator.
> 
> Properly supporting the "POST before switching to PM" would require a
> full real-mode bus/device resume. The ACPI specs doesn't even
> guarantee a working southbridge at real mode resume.

Not sure what you mean with "working southbridge". If you need 
PCI why not call the PCI BIOS to initialize it first? 

> "Later in an emulator" is arguably safer than real mode. But the
> emulation needs to be done from kernel at the proper point in the
> resume sequence. Leaving it to the user-mode suspend/resume script
> is not an option.

Why not? 

-Andi



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
