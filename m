From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI_BUS dependency for CONFIG_PNP
Date: 15 Nov 2004 11:42:47 -0500
Message-ID: <1100536966.5518.947.camel@d845pe>
References: <20041115114654.GJ1662@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041115114654.GJ1662-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-11-15 at 06:46, Andi Kleen wrote:
> 2.6.10rc2 got this new dependency:
> 
> config PNP
>         bool "Plug and Play support"
>         depends on ISA || ACPI_BUS
> 
> from the ACPI update. This enables ISA-PNP on x86-64, where
> it was always disabled previously and is completely useless. Can
> someone
> explain the rationale behind that change? IMHO you should never use
> ISA-PNP without CONFIG_ISA.

Linux PNP handles up to 3 protocols:
ISAPNP -- useful only if CONFIG_ISA, independent of PNPBIOS and PNPACPI
PNPBIOS -- useful only if acpi_disabled
PNPACPI -- useful if !acpi_disabled

drivers/pnp/isapnp/Kconfig appears to already have the dependency you're
looking for to make sure that ISAPNP is not defined without CONFIG_ISA:

config ISAPNP
        bool "ISA Plug and Play support"
        depends on PNP && ISA






-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
