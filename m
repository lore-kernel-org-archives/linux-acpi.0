From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila-9Aww8k/80nUxHbG02/KK1g@public.gmane.org>
Subject: Re: [PATCH][4/4] Add NUMA node handling to the container driver
Date: Fri, 24 Sep 2004 01:09:13 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41534989.3070001@kolumbus.fi>
References: <20040920092520.A14208@unix-os.sc.intel.com>	<20040920094719.H14208@unix-os.sc.intel.com>	<20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com> <20040924013642.00003b08.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040924013642.00003b08.tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhns-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Keiichiro Tokunaga wrote:

>Name: container_for_numa.patch
>Status: Tested on 2.6.9-rc2
>Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
>Description:
>Add NUMA node handling to the container driver.
>
>Thanks,
>Keiichiro Tokunaga
>---
>  
>

>@@ -198,6 +208,7 @@ container_device_add(struct acpi_device 
> 	if (acpi_bus_add(device, pdev, handle, ACPI_BUS_TYPE_DEVICE)) {
> 		return_VALUE(-ENODEV);
> 	}
>+	container_numa_add((*device)->handle);
>  
>
Maybe that should be :

container_numa_add(phandle);
 
instead? Device is the child at this point.

--Mika





-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
