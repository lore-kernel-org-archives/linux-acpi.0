From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi_get_object_info() and acpi_device_info
Date: Tue, 1 Oct 2002 13:06:58 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B7EB@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "'KOCHI, Takayoshi'" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


The reason we have the "valid" bitfield is that a Zero in at least some of
those fields (HID/UID/STA/ADR) is not enough information to determine that
the field is in fact invalid.

Therefore, the ONLY way to determine which fields are valid is to examine
the valid bits.  Thus, it becomes overkill to clear out the entire structure
first.  We of course clear the valid field and set the bits one-by-one as
the information becomes available.

This probably boils down to a philosophical debate -- but however, my
feeling is that the less code in the kernel, the better.

Any code that does not check the valid bits after this call is broken.

Bob


-----Original Message-----
From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org] 
Sent: Tuesday, October 01, 2002 11:13 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] acpi_get_object_info() and acpi_device_info

Hi,

I was tracking down a problem and found that acpi_get_object_info()
sometimes returns a partially initialized object.  I'd like to add a
line:

	memset(&info, 0, sizeof(acpi_device_info));

in acpi_get_object_info(), is it ok?

acpi_get_object_info() fills acpi_device_info structure, but if, for
example, _HID method evaluation fails, it won't fill `hardware_id'
member of acpi_device_info structure.  We can know which member is
initialized by `valid' member of the structure, but I think it's safe
to fill 0's before filling any contents.

Not all of the acpi_get_object_info() users cares it.  bus.c::acpi_bus_add()
handles `info' very carefully while nsdumpdv.c::acpi_ns_dump_one_device()
doesn't clear `info' variable nor check info.valid flag.

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm
