From: Christopher Allen Wing <wingc-fnGUqWb9lFPPwG6xszlCvg@public.gmane.org>
Subject: Re: suggestions for debugging ACPI IRQ routing in 2.6.11.6?
 (timer interrupt received twice)
Date: Tue, 5 Apr 2005 10:46:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0504051041310.13242@hammer.engin.umich.edu>
References: <971FCB6690CD0E4898387DBF7552B90E010F109B@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E010F109B-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks. I figured out the problem with iasl. I was using the 'acpixtract'
perl script to process the output from 'acpidmp'.

acpixtract is not compatible with Unicode-enabled Perl. It outputs a
corrupted file; specifically, it was outputting a file with:

	TableHeader.Length = 3250883

while the file itself was only 13783 bytes. Thus iasl crashed while trying
to compute the checksum past the end of the buffer.


By disabling unicode in perl via 'export LC_ALL=C', acpixtract generates a
correct file and iasl works for me.

I still have no idea what is wrong with the local APIC. I guess I have
more to learn about how this works...


Thanks,

Chris Wing
wingc-fnGUqWb9lFPPwG6xszlCvg@public.gmane.org


On Mon, 4 Apr 2005, Moore, Robert wrote:

> I'm surprised that iASL is crashing.  The checksum procedure is easy to
> debug, though.  The length of the table is in the table header.
>
> I've attached the disassembled file.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
