From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [ACPI-bugzilla] ACPI problems with new notebook
Date: Fri, 03 Jun 2005 15:54:51 +0800
Message-ID: <1117785291.7618.4.camel@linux-hp.sh.intel.com>
References: <1117707691.7839.21.camel@Notebook.stud.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1117707691.7839.21.camel-U5vG5gJ1EjE1HQ5cFjkM4zzqfiJFvRaJC3E89q3zG6w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tilo Lutz <TiloLutz-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
On Thu, 2005-06-02 at 18:21 +0800, Tilo Lutz wrote:
> Hi
> 
> I have some acpi problems with my new acer travelmate 3000. 
> It uses an intel 915gm chipset. 
> With pci=noacpi everything works but the sound. 
Does sound work with acpi=off?

> With acpi_irq_balance acpi_irq_pci=5,4,7,10 sound 
> works but firewire,pc-card and one usb port won't :(
> 
> I use Suse Linux 9.3, kernel 2.6.11.4 
> I had to fix the dsdt. 
> Any idea how I can get everything work?
> 
> Heres is the relevant part of dmesg when 
> acpi_irq_balance acpi_irq_pci=5,4,7,10 is used:
Please file a bug in bugzilla, so we can track it and please attach the
acpidmp output and dmesg with differrent boot option. And please send
email to acpi-dev list instead of acpi-bugzilla list.


Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
