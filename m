From: Nicolas Collignon <tsointsoin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: BIOS / acpi correlation
Date: Mon, 7 Feb 2005 20:05:27 +0100
Message-ID: <aaf57110502071105697f0780@mail.gmail.com>
Reply-To: Nicolas Collignon <tsointsoin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

hi,

Is there any correlation between bios exposed I/O memory ranges and
the SMI commands  used in DSDT code ?
i.e: i can control or display information using :
 "out %al, $0xb2"
 "out %al, $0x84"

In my DSDT, the code do SMI command like:
 "Store(arg1, \_SB.SMIA)"
 "Store(arg0, \_SB.SMIC)"
 "Store(\_SB.SMIC, Local0)"

SMIxx fields (\_SB scope)
 "OperationRegion(SMIR, SystemIO, 0xb2, 0x02) { Field(SMIR, ByteAcc,
NoLock ,Preserve) {"
 "  SMIC, 8"
 "  SMID, 8"
 "}"
and SMIA @ port 0x86.

But i can't find any correlation between the BIOS %eax parameter and
the SMI commands.
Shoudln't they share the same entry point ?
In my case, i can control multiple thermal zone + fan using bios, but
not using ACPI.

I hope my question is clear enough :)

bye

--- nicolas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
