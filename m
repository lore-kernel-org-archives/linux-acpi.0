From: Andrej Prsa <andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Subject: ACPI reboot hangs HP/Compaq 6120
Date: Wed, 6 Apr 2005 22:43:45 +0200
Message-ID: <20050406224345.1ece1377.andrej.prsa@guest.arnes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I'm continuing to experience problems with HP/Compaq 6120. This issue
isn't a killer, but is still annoying: when trying to reboot the
computer, it hangs at the very last step that says:

Rebooting...

After that only cold-boot helps. Any generic way to analyse the problem?

The original DSDT table:

	http://www.fiz.uni-lj.si/~prsa/acpi/dsdt.aml

The disassembled DSDT table using iasl -d:

	http://www.fiz.uni-lj.si/~prsa/acpi/dsdt.dsl

The precompiled DSDT table using iasl -tc:

	http://www.fiz.uni-lj.si/~prsa/acpi/dsdt.hex

Finally, perhaps a silly question: should APM by any chance be enabled
in kernel for rebooting to work? I presume not, since it's ACPI's job,
but I may be mistaking.

Thanks,

Andrej


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
