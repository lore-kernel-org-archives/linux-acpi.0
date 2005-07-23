From: widolo87 <widolo87-LWAfsSFWpa4@public.gmane.org>
Subject: problems compiling iasl on debian sarge
Date: Sat, 23 Jul 2005 02:25:14 +0200
Message-ID: <42E18E6A.8000204@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Hello.

I hope that my question is right on this list...


I just downloaded acpica-unix-20050624.tar.gz from
http://developer.intel.com/technology/iapc/acpi/downloads.htm to fix the
acpi implementation of my new laptop and tried to compile iasl.


Running make in the compiler directory results in

--snip--
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER \
	-I../include    -c -o aslcompilerlex.o aslcompilerlex.c

aslcompiler.l: In function `comment':
aslcompiler.l:847: error: `yytext_ptr' undeclared (first use in this  \
	function)
aslcompiler.l:847: error: (Each undeclared identifier is reported only \
	once
aslcompiler.l:847: error: for each function it appears in.)
make: *** [aslcompilerlex.o] Error 1
--snap--
(gcc-3.3.5, flex 2.5.31, bison 1.875d)

Unfortunately I have no idea of bison and of what's going on in this
source code.


I would be glad to receive any assistance.


All the best,


Maximilian Mehnert


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
