From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: IDE failure on ACPI resume
Date: Thu, 17 Mar 2005 16:08:13 -0800
Message-ID: <423A1BED.1010608@root.org>
References: <1110741241.8136.46.camel@tyrosine>  <423518E7.3030300@root.org>	 <1111072221.8136.171.camel@tyrosine>  <4239E9BA.7050105@root.org> <1111104154.8136.179.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111104154.8136.179.camel@tyrosine>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Thu, 2005-03-17 at 12:34 -0800, Nate Lawson wrote:
>>Very interesting.  I was hoping to someday have _GTF et al implemented 
>>but the ATA knowledge required was above my head.  I also strongly 
>>suspected that the info published by _GTF would likely be invalid.  Does 
>>Windows actually use that method or just hardcoded ATA initialization?
> 
> I believe that Windows does use the _GTF methods.

You are correct.  A quick scan of my w2k drivers shows atapi.sys uses 
the _GTF, _GTM, and _STM methods.

-- 
Nate


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
