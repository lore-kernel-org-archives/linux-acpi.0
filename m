From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: Re: [RFC/PATCH 0/3] ACPI based I/O APIC hot-plug
Date: Tue, 26 Apr 2005 23:34:42 +0900
Message-ID: <426E5182.70400@jp.fujitsu.com>
References: <4267AD0E.3080006@jp.fujitsu.com> <pan.2005.04.26.14.03.23.413590@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <pan.2005.04.26.14.03.23.413590-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Paul,

Paul Ionescu wrote:
> Hi Kenji,
> 
> On Thu, 21 Apr 2005 22:39:26 +0900, Kenji Kaneshige wrote:
> 
> 
>>Hi,
>>
>>Here is a set of patches to support ACPI based I/O APIC hotplug. This code
>>consists of the following three patches.
>>
>>    - Add the new interfaces for I/O APIC hot-add/hot-remove. The
>>      implementation of these interfaces depends on each architecture.
>>
>>    - IA64 implementation of above-mentioned interfeces for I/O APIC
>>      hot-add/hot-remove.
> 
> 
> Any plans for i386 implementation ?
> 

I want to work on i386 implementation, but I don't have enough time for
this... I hope someone will also work on this area for i386.

Thanks,
Kenji Kaneshige


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
