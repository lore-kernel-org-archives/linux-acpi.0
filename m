From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCHES] split up processor.c into pieces
Date: Sat, 27 Nov 2004 16:56:18 +0100
Message-ID: <20041127155618.GA3608@dominikbrodowski.de>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The following patches against 2.6.10-rc2-mm3 split up drivers/acpi/processor.c
into better manageable pieces. Also a small improvement to the throttling
subsystem is appended.

The individual patches are available at the place listed below. Oh, and I know that
applying 01 and 02 will break if !CONFIG_CPU_FREQ, but that's fixed in 03 and I'm too
lazy to re-diff as I think all these patches (or at least 01 to 05) should be applied
at the same time.

Please test and apply,
	Dominik

http://www.brodo.de/patches/2004-11-27/01-acpi-20041127-processor-splitup-perflib

Split the ACPI Processor P-States library into a different file

 drivers/acpi/Makefile            |    7
 drivers/acpi/processor.c         |  644 -------------------------------------
 drivers/acpi/processor_perflib.c |  666 +++++++++++++++++++++++++++++++++++++++
 include/acpi/processor.h         |   25 +
 4 files changed, 700 insertions(+), 642 deletions(-)


http://www.brodo.de/patches/2004-11-27/02-acpi-20041127-processor-splitup-throttling

Split the ACPI Processor T-States handling into a different file

 drivers/acpi/Makefile               |    2
 drivers/acpi/processor.c            |  314 --------------------------------
 drivers/acpi/processor_throttling.c |  351 ++++++++++++++++++++++++++++++++++++
 include/acpi/processor.h            |   22 ++
 4 files changed, 375 insertions(+), 314 deletions(-)


http://www.brodo.de/patches/2004-11-27/03-acpi-20041127-processor-splitup-idle

Split the ACPI Processor C-States handling into a different file

 drivers/acpi/Makefile         |    4
 drivers/acpi/processor.c      |  586 ---------------------------------------
 drivers/acpi/processor_idle.c |  629 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/processor.h      |    8
 4 files changed, 641 insertions(+), 586 deletions(-)


http://www.brodo.de/patches/2004-11-27/04-acpi-20041127-processor-splitup-thermal

Split the ACPI Processor passive cooling code into a different file

 drivers/acpi/Makefile            |    3
 drivers/acpi/processor.c         |  362 ----------------------------------
 drivers/acpi/processor_thermal.c |  406 +++++++++++++++++++++++++++++++++++++++
 include/acpi/processor.h         |   19 +
 4 files changed, 429 insertions(+), 361 deletions(-)


http://www.brodo.de/patches/2004-11-27/05-acpi-20041127-processor-splitup-core

Finalize the splitting of processor.c by moving the rest to processor_core.c

 drivers/acpi/Makefile         |    8
 drivers/acpi/processor.c      | 1046 ------------------------------------------
 drivers/acpi/processor_core.c | 1046 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1050 insertions(+), 1050 deletions(-)


http://www.brodo.de/patches/2004-11-27/06-acpi-20041127-throttling-disableirqsforshorterperiods

Shorten the times IRQs are disabled in throttling. During calculations
no disabling is necessary.

 drivers/acpi/processor_throttling.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
