From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Writing caches
Date: Wed, 09 Mar 2005 09:23:13 +1100
Message-ID: <1110317464.3663.9.camel@desktop.cunningham.myip.net.au>
References: <20050308101229.GD4154@pico.ruhr.de>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050308101229.GD4154-Q4Z/ui9EqVxM7kwft8N7nw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Tomanek <stefan-Q4Z/ui9EqVxM7kwft8N7nw@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

You can set a soft image size limit, and suspend2 will call
shrink_all_memory (like swsusp does) to free pages until it reaches that
limit (if possible). In this way it is possible to free caches before
suspending. As Lorenzo said, though, this results in a much less
responsive system post-resume. Suspend2 reads and writes the data as
fast as it can (async I/O and readahead for what must be done
synchronously due to compression, plus LZF compression), and the data is
stored as contiguously as possible. This means it's much faster to write
the data in the image instead of forcing pages to be reread/swapped in
later.

Regards,

Nigel

On Tue, 2005-03-08 at 21:12, Stefan Tomanek wrote:
> Just a small question, maybe I got a completely false impression...
> Why does software suspend have to save file cachess? Couldn't they just
> be flushed to save suspend and restore time?
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
