From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: acpi_sbs with kernel 2.6.11
Date: Fri, 11 Mar 2005 00:49:36 +0000
Message-ID: <1110502177.8136.6.camel@tyrosine>
References: <75eeb70e0503092013562a05d@mail.gmail.com>
	 <75eeb70e05030921185b337dd2@mail.gmail.com>
	 <4230A2BD.6090609@bartol.udel.edu> <1110500644.8136.1.camel@tyrosine>
	 <4230E9E9.2010600@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4230E9E9.2010600-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-03-10 at 19:44 -0500, Rich Townsend wrote:

> So I should instead be looking to implementing the SBS stuff in the HAL? 
> Sounds good to me. Where's the main site for the HAL work?

http://hal.freedesktop.org/wiki/Software_2fhal is the main site - you
want the CVS code, I believe. The mailing list archives ought to have
more information on the current code.

Gnome will certainly be moving to using hal for battery status in the
next release - I believe that KDE will be moving in that direction post
3.4 as well.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
