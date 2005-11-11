From: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: acpi_memhotplug driver is not working for me. Any ideas?
Date: Thu, 10 Nov 2005 18:45:35 -0800
Message-ID: <1131677135.20603.22.camel@knk>
References: <1131399845.6313.73.camel@knk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1131399845.6313.73.camel@knk>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-11-07 at 13:44 -0800, keith wrote:
> Hello,
>   I have recently acquired an IBM x460 to work with.  The hardware is
> completing it's hot add memory event just fine but the acpi code is
> retuning errors. (I implemented some stub functions the acpi code
> expects the arch to have)
> 


Ok I have found out more.  

The current driver is pretty complex perhaps too complex for my acpi
hardware event.  The current event handler calls acpi_memory_get_device
which presently fails. 

My event resource contains the ACPI_MEMORY_RANGE with the value of the
memory range that is hot-added.  It seem like I have enough information
to call add_memory.     

acpi_bus_get_device
acpi_get_parent
acpi_bus_get_device

are generic acpi functions that fail for my event.  Can someone please
explain what these are all about. (Really I don't understand the acpi
API this handler was coded too.)  I assume it is trying align itself to
a bus and parent but there really isn't a bus in this case and I don't
have any idea what the parent would be.  My SSDT doesn't really layout
any such relationships so I don't think the memory driver should require
them. 
I am working on a minimalisic event driver that works for my hardware
and will hopefully post code tomorrow sometime.  

Thanks,
  Keith Mannthey 
  LTC xSeries 




-- 
keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
