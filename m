From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Wed, 3 Nov 2004 13:38:30 +0100
Message-ID: <20041103123830.GB1002@elf.ucw.cz>
References: <20041018112632.GB4400@openzaurus.ucw.cz> <20041021001331.69c6c965@localhost.localdomain> <20041020225334.GC29863@elf.ucw.cz> <20041101145410.GB12006@tate.loria.fr> <20041101154127.GB1056@elf.ucw.cz> <20041102220034.GA31435@tate.loria.fr> <20041102220958.GF1407@elf.ucw.cz> <20041103105106.GA4174@wotan.suse.de> <20041103111306.GA1002@elf.ucw.cz> <20041103123625.GA18867@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041103123625.GA18867-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: Emmanuel Thom?? <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>, ole.rohne-vJEk5272eHo@public.gmane.org, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > Well, it depends if you want to keep your work, I guess :-). Okay,
> > > > x86-64 can wait.
> > > 
> > > Or rather not apply this. I have no plans to support switch back
> > > to real mode on x86-64. It is just far too hackish and fragile.
> > > 
> > > Either do it before switching to protected/long mode or later
> > > in a emulator.
> > 
> > It can not be done before switching to long mode... because video bios
> > needs initialized PCI. As of emulator.... yes that could be way to go.
> 
> Initialized in what way?  If it's very simple you could do it in
> assembler or alternatively call the PCI BIOS to do it.

I guess agp bridge has to be initialized etc... It does not look like
task one would like to write in assembly. Okay, lets do this on i386,
first, then see how it can be done in better way on x86-64.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
