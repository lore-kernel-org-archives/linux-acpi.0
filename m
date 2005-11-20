From: Simon Bridge <corwin-OA6R/WnsTSZ02iOg2JU2CQ@public.gmane.org>
Subject: acer aspire 3003LC DSDT troubleshooting, reality check and FYI
 (error 1054 puzzle)
Date: Mon, 21 Nov 2005 00:27:46 +1300
Message-ID: <1132486066.7792.34.camel@localhost.localdomain>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Someone sing out if I am making a big mistake here.
AFAIK: this laptop is has not already a fixed dsdt for me to use.
Am doing all this in ubuntu 5.10 with 2.6.12 kernel. And I havn't done
any programming in 15 years! ooh - err...

*** dsdt.dsl code modification log: acer aspire 3003LC ***

http://www.cpqlinux.com/acpi-howto.html#fix_broken_dsdt
... has fixes for most common issues

decompiling and recompiling gives 8 errors and 1 warning...

I get:
warning 2078 for _WAK method
error 1061 for \_PR.CPU0._PPC (6x object does not exist)
error 1061 for Z007 (2x object does not exist)

got rid of the warning first - since I knew how to do that one:
=====
        Return(Package(0x02){0x00, 0x00})
inserted at the end of the method (before final curly brace.)
======

Now I get 8 errors and zero warnings.
The 8x 1061's still present...

"Object does not exist"
two possibilities - need to add \ to some scope variables
scope (_OSI) should be scope (\_OSI)?
Change one at a time and recompile after each one. If no effect, undo.
OR: add "External (\_OSI)
(but where to? presumably at the start ... we'll see.)

===== from HOWTO ===
# Error 1022 - Object does not exist

>> dsdt.asl 281: If(\_OSI) {
>> Error 1022 - Object does not exist ^ (\_OSI)

Add "External (\_OSI)". The next version of the compiler understands
that
_OSI is a reserved method name and the External won't be required.

# Error 1022 - Object does not exist

>> dsdt.asl 281: If(\_OSI) {
>> Error 1022 - Object does not exist ^ (\_OSI)

You should probably look for any "Scope" lines and add the leading "\"
there that is missing:

Change from:
Scope(_SB_) {
to:
Scope(\_SB_) {

Also ignore any "name" lines that do not have the leading slash. I do
not believe that the name lines would have to be modified in this
manner. I believe that it is written in such a way that the "\" among
other stuff is prepended to the beginning of these "name" lines.
=============

add External (Z007) in the definition block, these errors vanish.
add External (\_PR.CPU0._PPC) these errors vanish but replaced by:

dsdt.dsl   151:         Processor (CPU0, 0x00, 0x00008010, 0x06) {}
Error    1054 -                       ^ Name already exists in scope
(CPU0)

I can try fixing this error (plan A) or go through the scope statements
(plan B).

Plan A: try to find out what error means or if anyone else has
encountered it.
Google errormessage comes up blank.
ACIP HOWTO the sequel:
http://www.columbia.edu/~ariel/acpi/acpi_howto.html#dsdt_editing
suggests looking in:
http://www.columbia.edu/~ariel/acpi/acpi_howto.html#acpi_on_laptops
... to see if the error is documented.

I see a note that 2.6.13 fixes battery stuff? We'll see. Only have
2.6.12 ubuntu std kernel.
otherwise, a lot of reviews but no actual errors overcome and no
specific mention of my laptop. Skimmed some acer reviews just in case -
nada.

next stop: the ACPI spec is:
http://www.columbia.edu/~ariel/acpi/acpi_howto.html#specifications

plan B:... scope statements without preceding back-slash are:

149 scope(_PR)
3455 scope(_GPE)

changing these makes no difference. So I've put them back.
restored the External declairation. So I'm back to error 1054, CPU0
already exists in scope.

mailing list: http://lists.sourceforge.net/lists/listinfo/acpi-devel

maybe someone here knows what this error message means... subscribing.
Meanwhile: resort to inspired guesswork and scientific method...

The function in question is (line numbers supplied by me):

(149) Scope (_PR)
(150)     {
(151)         Processor (CPU0, 0x00, 0x00008010, 0x06) {}
(152)     }


Placing the External declairation *after* the line 152 seems to have
eliminated this error altogether.
There are now no errors and iasl output is:

root@infrared:/home/simon/programming# iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20050930 [Nov 20 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

ASL Input:  dsdt.dsl - 3474 lines, 121251 bytes, 1565 keywords
AML Output: DSDT.aml - 13981 bytes 377 named objects 1188 executable
opcodes

Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 542 Optimizations
root@infrared:/home/simon/programming#

Now I am free to insert this into the initrd in /boot and thus bypass
the bios dsdt.

Someone sing out if I am making a big mistake somewhere... in any case,
I'd like to know what is going on (like - what am I doing?)

Thanks in advance... simon









-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
