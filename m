From: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>
Subject: Re: bouncing keys and skipping sound with 2.6.11
Date: Mon, 07 Mar 2005 08:26:32 +0100
Message-ID: <422C0228.1000709@suse.de>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050228184414.GA31929@gondor.com> <20050302200632.GA24529@gondor.com> <20050306185539.GA2149@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050306185539.GA2149-7BUxKyILgIXQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Niehusmann <jan-7BUxKyILgIXQT0dZR+AlfA@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Jan Niehusmann wrote:

> By trying different kernel versions, I traced down the problem to the
> changes introduced between linux-2.6.11-rc2-bk9 and
> linux-2.6.11-rc2-bk10, and, more specifically, to the ACPI changes
> within that patch. (Therefore the Cc: to Len Brown, who wrote or
> submitted most of these changes, as far as I can tell from the
> changelog)

I bet you have CONFIG_ACPI_DEBUG enabled. Disable it or try to put
#define ACPI_ENABLE_OBJECT_CACHE 1
at the end of include/acpi/acpi.h (before the last #endif)
This fixed it for me (and some others).
There is also a patch for a "CONFIG_ACPI_DEBUG_LITE" from Thomas
Renninger on the acpi-devel list, which leaves some of the debugging in,
but disables the worst offenders IIUC.

Hope that helps,

     Stefan



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
