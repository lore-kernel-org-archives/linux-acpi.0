From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Compiling vbetool
Date: Mon, 07 Feb 2005 09:45:33 -0500
Message-ID: <42077F0D.5020206@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

I'm sure this isn't the correct place to post such a question, but I 
could find no other appropriate forum. Has anyone run into a problem 
trying to compile Matthew Garret's vbetool? Specifically:

if gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" 
-DPACKA                    GE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" 
-DPACKAGE=\"vbetool\" -DVERSION=\"0.2\"                      -I. -I. 
-g -Wall -Werror -pedantic -g -O2 -MT vbetool.o -MD -MP -MF ".deps/v 
                 betool.Tpo" \
   -c -o vbetool.o `test -f 'vbetool.c' || echo './'`vbetool.c; \
then mv -f ".deps/vbetool.Tpo" ".deps/vbetool.Po"; \
else rm -f ".deps/vbetool.Tpo"; exit 1; \
fi
In file included from /usr/include/stdlib.h:416,
                  from vbetool.c:14:
/usr/include/sys/types.h:62: error: conflicting types for 'dev_t'
/usr/include/linux/types.h:24: error: previous declaration of 'dev_t' 
was here
/usr/include/sys/types.h:72: error: conflicting types for 'mode_t'
/usr/include/linux/types.h:30: error: previous declaration of 'mode_t' 
was here
/usr/include/sys/types.h:77: error: conflicting types for 'nlink_t'
/usr/include/linux/types.h:33: error: previous declaration of 'nlink_t' 
was here
In file included from /usr/include/sys/types.h:216,
                  from /usr/include/stdlib.h:416,
                  from vbetool.c:14:
/usr/include/sys/select.h:78: error: conflicting types for 'fd_set'
/usr/include/linux/types.h:21: error: previous declaration of 'fd_set' 
was here
make: *** [vbetool.o] Error 1

It looks like my headers are somehow borked, but I'm not sure how to go 
about fixing this. BTW, this is on a Gentoo-based system, running 2.6.10 
with glibc 2.3.4.

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
