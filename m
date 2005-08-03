From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Acer Travelmate 4651lci: freeze 10-20s after resume (S3)
Date: Wed, 3 Aug 2005 08:09:16 +0200
Message-ID: <20050803060916.GD1399@elf.ucw.cz>
References: <3d64b7f405080112344201642d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3d64b7f405080112344201642d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bram Vandoren <brambi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

>    I try to configure suspend to ram on my new Acer TravelMate 4651lci. I
>    added the option acpi_sleep=s3_bios to my boot loader.
>    I can correctly suspend the laptop (echo -n mem > /sys/power/state).
>    When I enter a key the laptop resumes also. Unfortunately the laptop
>    freezes approximately 20 seconds later. The system doesn't react any
>    more. I also do not get any error message on the screen.
>    I uploaded lspci, dmidecode, acpidmp and lspci -vv and interrupts
>    to

Does it freeze without s3_bios option? Does it freeze in kernel or in
userspace?
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
