From: Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Subject: Re: Resume from mem state == Reboot (Averatec)
Date: Sun, 20 Mar 2005 22:45:54 -0800
Message-ID: <87eke94hul.fsf@www.codersbase.com>
References: <87k6oaug4a.fsf@www.codersbase.com>
	<1110840337.8136.82.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1110840337.8136.82.camel@tyrosine> (Matthew Garrett's message
 of "Mon, 14 Mar 2005 22:45:36 +0000")
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

Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> writes:

> This is likely to be the same problem as
> http://bugzilla.kernel.org/show_bug.cgi?id=3691

Has anyone made progress on this bug?  I've been trying various things
on my system to get an understanding of the problem.  But I don't
really know what I'm doing and I could really use some guidance.

What sort of information would be useful in troubleshooting this?
I've attached all the diagnostic output I know how to generate to the
bug listed above, but there must be something else I can do or try.

Today when I was poking around I did discover in tbconvert.c inside
the function acpi_tb_build_common_facs that
acpi_gbl_common_fACS.firmware_waking_vector is 0x0de8000c.  But in
acpi_pm_prepare the function acpi_set_firmware_waking_vector is given
a physical address of 0x00001000, which comes from a virtual address
of 0xc0001000.  Is there something I can inspect or disassemble to
find out what the firmware_waking_vector should be?

Thanks,
Jason


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
