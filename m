From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: acpi_sbs with kernel 2.6.11
Date: Thu, 10 Mar 2005 14:40:45 -0500
Message-ID: <4230A2BD.6090609@bartol.udel.edu>
References: <75eeb70e0503092013562a05d@mail.gmail.com> <75eeb70e05030921185b337dd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <75eeb70e05030921185b337dd2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Antoni Villalonga <frikimaster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Antoni Villalonga wrote:
> There are any patch for 2.6.11.x kernels for acpi_sbs driver? I had
> problems to use it with 2.6.11.2.
> 
> Tnx
> 

Not at the moment. I'm still trying to work out a coherent approach to 
bringing together Control Method and Smart batteries under the same code 
framework.

In the meantime, I'm planning to release, in the very near future, a 
version of the sbs-cm DSDT patches that works happily with 2.6.11. Keep 
an eye on the Sourceforge sbs-linux project page:

https://sourceforge.net/projects/sbs-linux/

cheers,

Rich


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
