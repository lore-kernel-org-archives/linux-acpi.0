From: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Subject: Re: RE: [PATCH] drivers/acpi/ac.c: convert to seq_file
Date: Wed, 27 Nov 2002 14:02:53 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DE524ED.4010902@prairienet.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A50E@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Arnaldo Carvalho de Melo' <acme-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>From: Arnaldo Carvalho de Melo [mailto:acme-KCZ47A4bww4P48s/oLjRZg@public.gmane.org] 
>>	Please consider pulling from:
>>
>>bk://oops.kerneljanitors.org:acpi-2.5
>>
>>	This is the first in a series of changesets converting
>>ACPI to seq_file, please lets us know if something is unacceptable.
>>
>>	The work was done by Aristeu Rozanski.
> 
> 
> Hi acme,
> 
> Looks like an improvement. My thanks to you and Aristeu.
> 
> Let me know when you're done with all the changesets and I'll pull
> everything.
> 
> Regards -- Andy


This is coming too late, but I kind of object to these changes on the 
grounds that there is an oversight in the handling of userdata between 
proc_fs and seq_file.  Although the use of seq_file cleans up obscure 
proc read code, it also eliminates the option of writing proc handlers 
in an object-oriented style.

When I saw the seq_file patch to the toshiba_acpi module 
(http://linux.bkbits.net:8080/linux-2.5/patch-9BHYcwbM+ZDX/YFgETsMoA@public.gmane.org), my reaction 
was that things were now too verbose and redundant, and it was time for 
me to move to data-driven generic code.  I knew this option was 
available because proc_dir_entry carries a userdata field which is 
passed to all the handlers.  While seq_file also has userdata support, 
the problem is that proc_fs does not propegate its userdata to seq_file. 
  The only way to set the seq_file userdata is in the open handler, 
which as far as I can tell does not have access to the proc_dir_entry. 
The result is a proliferation of nearly-identical functions and tables 
that could otherwise be factored out.

In summary, what I'm looking for is a way to pass in a userdata at 
proc_dir_entry creation time, and have this data available in the read 
handler, without resorting to redundant tables and wrapper functions or 
macro trickery.  This was, after all, completly feasible prior to the 
use of seq_file.

If I've overlooked something please let me know, before I stick my foot 
in my mouth on the kernel list.


Regards,
-John



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
