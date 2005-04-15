From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Portege 7010CT CPU speed
Date: Fri, 15 Apr 2005 15:17:57 +0200
Message-ID: <20050415131757.GD2298@poupinou.org>
References: <20050412035916.GB7304@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050412035916.GB7304-eRi7t0xs5gloIlNlpBNreQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ryan Underwood <nemesis-lists-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 11, 2005 at 10:59:16PM -0500, Ryan Underwood wrote:
> 
> Hello,
> 
> My friend has a Portege 7010CT that seems to have two ACPI-related
> problems.  This is under 2.4.27 with ACPI enabled as well as 2.6.11.  I
> posted the DSDT on the sourceforge site.  ACPI gives some method errors
> when starting up but seems to otherwise "work".

You hit the (in)famous 'toshiba return bug'.  That should be fixed with
recent version of ACPI-CA (read: may not work with 2.6.11, but should
work with upcomming 2.6.12).

> The first issue is minor.  In ACPI mode, Cardbus cards don't work unless
> pci=noacpi is given.  It seems no IRQ is received by the kernel from the
> Cardbus controller in this case.  After giving pci=noacpi, I notice no
> problems otherwise with PCI or IRQ routing.

Its due to the return bug.

> The second is a huge problem.  The CPU is a PII-300MHz, but after
> booting Linux, the machine is suddenly only running at 150MHz as shown
> by bogomips compared to the bogomips of a normal PII-300.  Rebooting
> into Windows preserves the speed.  I was able to use WCPUID to query the
> speeds.  It shows that the FSB is only running at 33MHz instead of 66MHz
> producing a 150MHz CPU clock.  Powering off completely and powering on
> then booting straight to WinXP has the correct 300MHz speed.
> 
> Does anyone have even half a clue what would be going on here?  It's
> sort of embarassing having to explain to him that it's likely not
> "Linux" fault but rather the fault of a broken BIOS or DSDT.  How can I
> figure out what the real problem is?  It is not APIC related because the
> APIC is not being enabled.  I have attached various logs.

Don't know, sorry.

> Also, the sound system is PnP in Windows but for some reason isapnp
> doesn't pick it up.  I guess this is because it is only announced by
> PnPBIOS support, which presumably PnP-ACPI should be utilizing, right?

ACPI supersed PnPBIOS which means it do not use at all PnPBIOS
services.

> Am I correct in presuming that hotplug should automatically load the
> sound system module if PnP-ACPI is correctly working?  This isn't a big
> deal because the sound does work, it's just having to manually configure
> the resources is a pain in the ass (and neither any OSS mixer nor the
> ALSA driver works on this particular hardware...)

Unfortunately, it seems looking the dmesg that again you hit that
(in)famous return bug.

> I posted to the linux-toshiba list but nobody replied with any useful
> information.  I tried using toshset to set the CPU speed to 'fast', but
> it didn't seem to have any effect on benchmarks, and after rebooting
> into Windows the system is still at 150MHz.
> 
> This is a decent laptop but Linux sucks on it at the moment; I'm hoping
> to figure out what's going on not only to improve the state of Linux but
> also because it might end up being a hand-me-down in the future ;)
> 

You should try the very latest acpi bk-patch and report if that work or
not.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
