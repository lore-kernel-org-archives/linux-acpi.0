From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Shutting down PCI devices on suspend
Date: Sun, 12 Dec 2004 23:23:40 +0000
Message-ID: <1102893820.5984.42.camel@tyrosine>
References: <1102779460.5984.17.camel@tyrosine>
	 <20041212164422.GD6286@elf.ucw.cz> <1102870863.5984.36.camel@tyrosine>
	 <20041212171521.GC6272@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041212171521.GC6272-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-12-12 at 18:15 +0100, Pavel Machek wrote:

> * legacy, like VGA or IDE -- okay, we need drivers for those. You need
> to reinit them on resume, anyway, so....
							
The current situation is that we can reinit /most/ VGA hardware from
userspace, but it's less than trivial to make sure that the appropriate
devices are shut down. Surely the situation is more like the following:

1) Some devices don't have drivers. In most cases, it doesn't matter
what power state they're in. Therefore, setting them to D3 (or whatever
SxD says) shouldn't be a problem.

2) For devices that do have drivers, the drivers should set them to the
appropriate power state.

I'd argue that devices that need to be in a specific power state but
whose drivers don't state this have broken drivers. If there's no driver
in charge of the device, we should be able to do whatever we want.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
