From: Perry Hutchison <phutchis-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: which processor am I
Date: Wed, 29 Jun 2005 16:28:04 -0700 (PDT)
Message-ID: <200506292328.QAA79162@riparian.beaverton.windriver.com>
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

Suppose the currently-executing processor, on an MP platform which
provides only ACPI-1.0 tables, has determined that it should put
itself into C2.  How does it figure out which P_BLK to use, so as
to stop itself and not the other processor?  (I am assuming that
it it *possible* for the processor to put only itself into C2,
granted in 1.0 there is no way for the tables to specify the
presence or absence of such dependencies.)

One way would be to look in \_PR for the Processor object with the
correct ProcessorId, but that would require a way for a processor
to determine its own ProcessorId.

This feels like a question whose answer should be blindingly obvious,
but I am not finding it in the specification or the 4/18/2003 ACPICA
Programmer Reference, nor in a brief look through the 20050513
ACPICA distribution (where I found code to enter S states but not
C states).  Maybe I'm not looking for the right thing.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
