From: "Wang, Zhenyu" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: How to control Thermal zone
Date: Fri, 10 Dec 2004 09:10:29 +0800
Message-ID: <20041210011029.GA28676@zhen-devel.sh.intel.com>
References: <41B8FC12.5090602@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41B8FC12.5090602-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Cc: ACPI devel list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> 
> Hi guys,
> 
> sorry if this has been already asked,
> 
> but I'd like to know if is it possible to control thermal zone in order
> to turn off my laptop fan when I get my login screen.
> 
> I mean, The fan is being correctly turned on and off but only after
> getting some threshold. When the laptop is turned on and my thermal zone
> temp is 35C fan is kept on when it could be turned off.
> 
> Any tips?
> 

Have you loaded acpi fan module? Have you got any device under /proc/acpi/fan?
Try to trigger on/off to that device. 

cheers
zhen


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
