From: Matej Cepl <cepl-ZO4F0KnmCDHk1uMJSBkQmQ@public.gmane.org>
Subject: Fixing DSDT -- parse error, unexpected PARSEOP_STORE
Date: Fri, 22 Oct 2004 17:57:20 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <12359312.YVPq5tOtZN@blahoslav.ceplovi.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3407196.lW23enK3OM"
Content-Transfer-Encoding: 7Bit
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

--nextPart3407196.lW23enK3OM
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8Bit

Hi,

trying to fix DSDT in my no-name computer (so no help from precompiled DSDTs
on acpi.sf.net), I have got the attached .log file when trying to recompile
dissassembled DSDT. However, when I tried to google PARSEOP_STORE error, I
have found nothing. Can anybody help me to understand what's wrong, please
(I do not have to add that I am totally non-CS and newbie in whole ACPI
business, do I)?

 Thanks a lot,

  Matej Cepl


-- 
Matej Cepl, http://www.ceplovi.cz/matej
GPG Finger: 89EF 4BC6 288A BF43 1BAB  25C3 E09F EF25 D964 84AC
138 Highland Ave. #10, Somerville, Ma 02143, (617) 623-1488
 
All parts should go together without forcing. You must remember
that the parts you are reassembling were disassembled by you.
Therefore, if you can't get them together again, there must be a
reason. By all means, do not use a hammer.
    -- IBM maintenance manual, 1925
--nextPart3407196.lW23enK3OM
Content-Type: application/x-gzip; name="dsdt.dsl.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dsdt.dsl.gz"

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
--nextPart3407196.lW23enK3OM
Content-Type: text/plain; name="dsdt.log"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="dsdt.log"

Loading Acpi table from file dsdt.blahoslav
Acpi table [DSDT] successfully installed and loaded
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
.............................................................................................................................................
Parsing completed
Disassembly completed, written to "dsdt.dsl"

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040715 [Aug 24 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c


Compiling "dsdt.dsl"
dsdt.dsl   310:     Store (TP1H, CTOS)
Error    1037 -         ^ parse error, unexpected PARSEOP_STORE

ASL Input:  dsdt.dsl - 2007 lines, 65190 bytes, 140 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

--nextPart3407196.lW23enK3OM--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
