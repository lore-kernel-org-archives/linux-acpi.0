From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: i855-based ThinkPad STR: Graphics device stays in D3
	after resume
Date: Wed, 13 Apr 2005 01:50:40 +0100
Message-ID: <1113353440.10110.96.camel@tyrosine>
References: <200504122032.36053.barr.156@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504122032.36053.barr.156-ZbGKxL/pcrQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-04-12 at 20:32 -0400, Andrew Barr wrote:

> Basically, these people did a BIOS upgrade that seems to have borked 
> suspend-to-RAM on their ThinkPads. My ThinkPad is very new, so it shipped 
> with a BIOS with this problem. I am going to try downgrading to BIOS and 
> Embedded Controller versions mentioned in the above-referenced threads, but I 
> did discover something interesting. The graphics device stays in D3 after 
> resuming from S3 (I can ssh into my laptop). Here is the output of 'lspci 
> -vvvxxx -s 00:02.0' before S3:

Hmm. Interesting. There's no code that will actually have bound to the
PCI device (well, other than the drm driver, but that's different in
magical ways), so the kernel won't attempt to reenable it on resume.

We really should be doing something about devices that the kernel has no
drivers for - at the moment, unless there's a driver loaded, we don't
power down the device at all. However, I'm not entirely clear on /what/
we should be doing.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
