From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Acer TravelMate 3200 series
Date: Fri, 18 Feb 2005 11:18:12 +0100
Message-ID: <m2sm3u189n.fsf@phoenix.squirrel.nl>
References: <42139CFB.4000708@panafonet.gr> <42139D82.5090709@bartol.udel.edu>
	<4214E65E.2020202@panafonet.gr> <4214E6DE.3010702@bartol.udel.edu>
	<89c8fbaa0502180120276cee49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <89c8fbaa0502180120276cee49-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org> (Gerard Soldevila's
 message of "Fri, 18 Feb 2005 10:20:12 +0100")
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

Gerard Soldevila <soldevila-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> Power Management Options (ACPI, APM ) --->
> ACPI (Advanced Configuration and Power Interface) Support  --->
> [*]   Include Custom DSDT
> (/etc/dsdt.hex) Custom DSDT Table file to include

> I tried to load DSDT by this method (with 2.6.10) but no battery
> status is shown and the loaded DSDT seems to be the original (diff
> shows no ouptut)
>
> I encourage you to patch your kernel to read DSDT dinamically from initrd.

I use the kernel override technique all of the time, and it works
perfectly. (I need to override the DSDT since the original DSDT has
the wrong CPU frequencies in it. So I can immedeately see that its
overridden.) There should be no difference whether the DSDT is
overriden this way, or from the initrd (read the patch, it's clear).

You can verify that he DSDT was actually overridden by inspecting
dmesg:

    ACPI-0294: *** Info: Table [DSDT] replaced by host OS

-- Johan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
