From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH 5/6]ACPI based Physical CPU hotplug
Date: Thu, 9 Sep 2004 14:18:10 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040909141809.A16106@unix-os.sc.intel.com>
References: <44BDAFB888F59F408FAE3CC35AB47041B17999@orsmsx409> <20040908184011.C7384@unix-os.sc.intel.com> <4140BFA3.1070508@kolumbus.fi>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4140BFA3.1070508-9Aww8k/80nUxHbG02/KK1g@public.gmane.org>; from mika.penttila-9Aww8k/80nUxHbG02/KK1g@public.gmane.org on Thu, Sep 09, 2004 at 11:40:03PM +0300
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mika Penttil? <mika.penttila-9Aww8k/80nUxHbG02/KK1g@public.gmane.org>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LHNS list <lhns-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI Developer <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 09, 2004 at 11:40:03PM +0300, Mika Penttil? wrote:
> I don't see how the acpi_processor_start() stuff (which was formerly in 
> acpi_processor_add()) gets executed in the plain non-hotplug case. It's 
> only called from the hotplug notifications.
Hi Mika,
	Firstly thanks for your time looking at the code and let me clarify you concerns.
If you look at acpi_bus_driver_init() function from where the ops.add() is getting called, 
once the ops.add() gets passed, and if the driver has .start function defined 
then ops.start() is called. In our case the processor driver is setting
.start to acpi_processor_start function in its acpi_processor_driver structure.

Let me know if you have any other concerns.

Thanks,
Anil Keshavamurthy



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
