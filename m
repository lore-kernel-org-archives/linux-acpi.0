From: Ralf Gerbig <rge-ihuhiKcgPLSELgA04lAiVw@public.gmane.org>
Subject: Re: Radeon M7 and resuming from suspend-to-ram
Date: Thu, 03 Feb 2005 23:53:25 +0100
Message-ID: <87oef1gsre.fsf@gerlin1.hsp-law.de>
References: <41E7D334.6060003@sllpilots.fi>
	<1105723866.28126.10.camel@elrond.flymine.org>
	<87k6qal75i.fsf-news@hsp-law.de> <1106095573.7368.29.camel@tyrosine>
	<87ekghkwt0.fsf-news@hsp-law.de> <42029281.3070207@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42029281.3070207-hi6Y0CQ0nG0@public.gmane.org> (Carl-Daniel Hailfinger's message of
 "Thu, 03 Feb 2005 22:07:13 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Moins,

* Carl-Daniel Hailfinger:
> Ralf Gerbig schrieb:
>> Compiling the source I got: 
>> 
>> rge@lapdog2:/usr/src/vbetool-0.2> make
>> if gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" 
>> -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"vbetool\" 
>> -DVERSION=\"0.2\"  -I. -I.    
>> -g -Wall -Werror -pedantic -g -O2 -MT vbetool.o -MD -MP -MF ".deps/vbetool.Tpo" \
>> -c -o vbetool.o `test -f 'vbetool.c' || echo './'`vbetool.c; \
>> then mv -f ".deps/vbetool.Tpo" ".deps/vbetool.Po"; \
>> else rm -f ".deps/vbetool.Tpo"; exit 1; \
>> fi
>> In file included from /usr/include/stdlib.h:416,
>> from vbetool.c:14:
>> /usr/include/sys/types.h:62: error: conflicting types for `dev_t'
>> /usr/include/linux/types.h:22: error: previous declaration of `dev_t'
>> [...]

> Yes, the pci.h shipped by SUSE has problems. Simply move the #include
> <pci/pci.h> from the beginning to directly before #include <sys/kd.h>

>> after fuzing around with -D, I temporally commented out the
>> include. Thereafter adding -lpci to the end of the link command, I got
>> a working executable.

> This is a bug in Makefile.am. Pseudo-diff:

> -AM_LDFLAGS = -lpci
> +LIBS = -lpci

> Then run aclocal, autoconf and automake again.


yup, works with this diff:

--- ../vbetool-0.2-orig/Makefile.am     2004-12-30 16:27:07.000000000 +0100
+++ Makefile.am 2005-02-03 23:38:08.000000000 +0100
@@ -12,4 +12,4 @@
        $(RM) Makefile.in aclocal.m4 config.h.in stamp-h.in configure
 
 AM_CFLAGS = -g -Wall -Werror -pedantic
-AM_LDFLAGS = -lpci
+LIBS = -lpci

--- ../vbetool-0.2-orig/vbetool.c       2004-12-31 16:11:19.000000000 +0100
+++ vbetool.c   2005-02-03 23:38:40.000000000 +0100
@@ -8,7 +8,6 @@
 version 2
 */
 
-#include <pci/pci.h>
 #include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -17,6 +16,7 @@
 #include <sys/ioctl.h>
 #include <sys/types.h>
 #include <sys/io.h>
+#include <pci/pci.h>
 #include <sys/kd.h>
 #include <sys/stat.h>
 #include <errno.h>

Ralf


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
