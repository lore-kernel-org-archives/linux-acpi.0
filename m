From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: sbs-linux acpi-ec-nospinlock patch for 2.6.11
Date: Fri, 11 Mar 2005 11:37:26 -0500
Message-ID: <4231C946.4090301@bartol.udel.edu>
References: <3ACA40606221794F80A5670F0AF15F8407663381@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8407663381@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Yu, Luming wrote:
> I don't know what is acpi-ec-nospinlock patch.
> But the patch at http://bugzilla.kernel.org/show_bug.cgi?id=3851#c52 is worthy testing, if you have EC related issue.
> Thanks,
> Luming

It was a small patch I wrote, to lock EC access using a semaphore rather 
than a spinlock. This was to stop the stuttering caused when the EC 
driver was polling for completion of a transaction.

Eventually, of course, we want to switch over to event-based EC 
management. I already tried one of the older EC/event patches on the 
page you give above, with not much success; but I'll give one of the 
newer ones a shot.

I'm currently also playing around with a patch sent to me by Dmitry 
Torokhov, which I believe was a fork from the EC/event patches. It seems 
to work (in that there is no more stuttering), but there are a lot of 
AE_TIME errors returned by the address-space handler, which screws up 
execution of many DSDT methods that use the EC.

cheers,

Rich


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
