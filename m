From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
Date: Fri, 4 Mar 2005 01:43:35 -0800
Message-ID: <20050304014335.319b9165.akpm@osdl.org>
References: <422618F0.3020508@telefonica.net>
	<20050302134342.4c9cc488.akpm@osdl.org>
	<20050304092333.GA11862@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050304092333.GA11862-NfIQswJzSEaq9fEpoSJUslHdEuJhDOxL@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Cc: romanol-qvIf60buks8@public.gmane.org, miguelanxo-XnAhQTnVLytMqUckJh7upg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Romano Giannetti <romanol-qvIf60buks8@public.gmane.org> wrote:
>
> On Wed, Mar 02, 2005 at 01:43:42PM -0800, Andrew Morton wrote:
> > 
> > That's an ACPI problem, I assume?
> > 
> 
> Probably. There is something flaky in ACPI event (it happened sometime
> between 2.6.7 and 2.6.9, i tried to check all the patches, but I had find
> nothing. 
> 
> Could someone please check http://bugme.osdl.org/show_bug.cgi?id=4124 and
> tell me what to do to help in debugging it? 
> 
> What is very strange is why "power button" and "read battery current capacity" 
> events are working ok, and "sleep button" or "CRT switch button" or "ac
> plugged/unplugged" seems more or less random delayed. 
> 

Add acpi-devel to cc...


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
