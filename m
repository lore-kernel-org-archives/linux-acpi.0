From: Grant Grundler <grundler-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Subject: help for ACPI_CONTAINER sucks
Date: Sat, 15 Jan 2005 15:21:29 -0700
Message-ID: <20050115222129.GB10070@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


Help for ACPI_CONTAINER is just useless:
                This is the ACPI generic container driver which supports
		ACPI0004, PNP0A05 and PNP0A06 devices.

Help should explain what those devices are and what might not work
unless I enable ACPI_CONTAINER. As a !acpi_developer I have no clue
and am just annoyed by the question.

Here is a fictious example (I have no clue about ACPI) might provide
some guidance on what I was expecting:
	The ACPI generic container driver provides support for:
	ACPI0004 - Hotplug IO
	PNP0A05  - Hotplug CPU
	PNP0A06  - Hotplug Memory
	
	One can use those devices but can't access hotplug features
	unless this option is enabled.

	If one selects "m", this driver can be loaded with
	"modprobe acpi_container".

hth,
grant


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
