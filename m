From: "Daniel Blueman" <daniel.blueman-hi6Y0CQ0nG0@public.gmane.org>
Subject: [asl compiler] flex build issues...
Date: Sun, 24 Oct 2004 23:26:22 +0200 (MEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20470.1098653182@www28.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

There is still the requirement that the current Intel ACPI iasl compiler [1]
be built with an old version of 'flex', otherwise we see build failures [2].

Any idea when this may get resolved?

Please CC me directly on any replies.

--- [1]

http://developer.intel.com/technology/iapc/acpi/downloads.htm

--- [2]

flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../include 
  -
c -o aslcompilerlex.o aslcompilerlex.c
aslcompiler.l: In function `comment':
aslcompiler.l:837: error: `yytext_ptr' undeclared (first use in this
function)
aslcompiler.l:837: error: (Each undeclared identifier is reported only once
aslcompiler.l:837: error: for each function it appears in.)
make: *** [aslcompilerlex.o] Error 1

-- 
Daniel J Blueman

Geschenkt: 3 Monate GMX ProMail + 3 Ausgaben der TV Movie mit DVD
++++ Jetzt anmelden und testen http://www.gmx.net/de/go/mail ++++



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
