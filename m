From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: acpi_sbs with kernel 2.6.11
Date: Thu, 10 Mar 2005 19:44:25 -0500
Message-ID: <4230E9E9.2010600@bartol.udel.edu>
References: <75eeb70e0503092013562a05d@mail.gmail.com>	 <75eeb70e05030921185b337dd2@mail.gmail.com>	 <4230A2BD.6090609@bartol.udel.edu> <1110500644.8136.1.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110500644.8136.1.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Thu, 2005-03-10 at 14:40 -0500, Rich Townsend wrote:
> 
> 
>>Not at the moment. I'm still trying to work out a coherent approach to 
>>bringing together Control Method and Smart batteries under the same code 
>>framework.
> 
> 
> hal has recently gained the ability to parse control method battery
> status. Adding support for smart batteries is trivial. There's no need
> to unite battery status at the kernel level, especially since we'll need
> to support apm and pmu batteries as well.
> 

So I should instead be looking to implementing the SBS stuff in the HAL? 
Sounds good to me. Where's the main site for the HAL work?

cheers,

Rich



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
