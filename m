From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: New ACPI patch available for 2.6.10 and 2.6.11
Date: 26 Jan 2005 03:44:10 -0500
Message-ID: <1106729049.2397.317.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
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
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

An updated ACPI patch including mostly an update to the ACPI interpreter
is available here:

for 2.6.11:
bk pull bk://linux-acpi.bkbits.net/to-linus
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.11/acpi-20050125-2.6.11-rc2.diff.gz

for 2.6.10:
bk pull bk://linux-acpi.bkbits.net/26-stable-test
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.10/acpi-20050125-2.6.10.diff.gz

As fixes in the AML intepreter always carry risk of unexpected
regressions, I'd appreciate any testing feedback you might
be able to provide before this patch hits the mm patch.

thanks,
-Len
------------

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/01/26 1.1938.497.8)
   [ACPI] ACPICA 20050125 from Bob Moore
   
   Fixed a recently introduced problem with the Global
   Lock where the underlying semaphore was not created.
   This problem was introduced in version 20050114, and
   caused an AE_AML_NO_OPERAND exception during an Acquire()
   operation on _GL.
   
   The local object cache is now optional, and is disabled
   by default.  #define ACPI_ENABLE_OBJECT_CACHE to enable
   the local cache.
   
   Fixed an issue in the internal function
   acpi_ut_evaluate_object() concerning the optional "implicit
   return" support where an error was returned if no return
   object was expected, but one was implicitly returned. AE_OK
   is now returned in this case and the implicitly returned
   object is deleted.  acpi_ut_evaluate_object() is only
   occasionally used, and only to execute reserved methods
   such as _STA and _INI where the return type is known
   up front.
   
   Fixed a few issues with the internal convert-to-integer
   code. It now returns an error if an attempt is made to
   convert a null string, a string of only blanks/tabs, or a
   zero-length buffer. This affects both implicit conversion
   and explicit conversion via the ToInteger() operator.
   
   The internal debug code in acpi_ut_acquire_mutex()
   has been commented out. It is not needed for normal
   operation and should increase the performance of the entire
   subsystem. The code remains in case it is needed for debug
   purposes again.
   acpica-unix-20050125.patch

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/01/21 1.1938.497.7)
   [ACPI] avoid benign AE_TYPE warnings
   caused by "implicit return" BIOS workaround
   returning unsolicited (and thus mis-typed) AML values.
   
   Signed-off-by: Bob Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/01/21 1.1938.497.6)
   [ACPI] ACPICA 20050114 from Bob Moore
   
   Added 2005 copyright to all ACPICA files.
   
   Fixed an issue with the String-to-Buffer conversion code
   where the string null terminator was not included in the
   buffer after conversion, but there is existing ASL that
   assumes the string null terminator is included. This is the
   root of the ACPI_AML_BUFFER_LIMIT regression. This problem
   was introduced in the previous version when the code was
   updated to correctly set the converted buffer size as per
   the ACPI specification. The ACPI spec is ambiguous and
   will be updated to specify that the null terminator must
   be included in the converted buffer. This also affects
   the ToBuffer() ASL operator.
   
   Fixed a problem with the Mid() ASL/AML operator where it
   did not work correctly on Buffer objects. Newly created
   sub-buffers were not being marked as initialized.
   
   Fixed a problem in acpi_tb_find_table where incorrect string
   compares were performed on the oem_id and oem_table_d table
   header fields.  These fields are not null terminated,
   so strncmp is now used instead of strcmp.
   
   Implemented a restriction on the Store() ASL/AML operator
   to align the behavior with the ACPI specification.
   Previously, any object could be used as the source
   operand.  Now, the only objects that may be used are
   Integers, Buffers, Strings, Packages, Object References,
   and DDB Handles.  As acpi_gbl_enable_interpreter_slack
   is FALSE by default, "acpi=strict" is needed to enable
   this check.
   
   Enhanced the optional "implicit return" support to allow
   an implicit return value from methods that are invoked
   externally via the AcpiEvaluateObject interface.  This
   enables implicit returns from the _STA and _INI methods,
   for example.
   
   Changed the Revision() ASL/AML operator to return the
   current version of the AML interpreter, in the YYYYMMDD
   format. Previously, it incorrectly returned the supported
   ACPI version (This is the function of the _REV method).
   
   Updated the _REV predefined method to return the currently
   supported version of ACPI, now 3.

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/01/20 1.1938.497.5)
   [ACPI] Add a module parameter to allow tuning how much bus-master
activity
   we remember when entering C3 --
/sys/module/processor/parameters/bm_history
   Default varies with HZ -- 40ms for 25 - 800 HZ, 32ms for 1000 HZ.
   
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/01/20 1.1938.497.4)
   [ACPI] Make the bm_activity depend on "jiffies", instead of numbers
   of the check being called. This means bus mastering activity
   is assumed if bm_check isn't called; and multiple calls during
   one jiffy will be |='ed.
   
   Signed-off-by: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/01/07 1.1938.497.3)
   [ACPI] Use kernel.h for ARRAY_SIZE() instead of using local NUM_OF().
   
   Signed-off-by: Randy Dunlap <rddunlap-3NddpPZAyC0@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
