From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: acpidump usage
Date: Thu, 25 Aug 2005 11:56:13 +0400
Message-ID: <6694B22B6436BC43B429958787E454983CBC18@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mattia Dongili <malattia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ACPI Devel Maling List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Acpidump by default dumps all tables (not just DSDT) in hexdump format.=20
Iasl wants to have single table (say DSDT) in binary format.
Acpidump -b -t DSDT -o DSDT.aml will make you one.

Regards,
	Alex. =20

-----Original Message-----
From: Mattia Dongili [mailto:malattia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]=20
Sent: Wednesday, August 24, 2005 11:20 PM
To: Starikovskiy, Alexey Y
Cc: Thomas Renninger; ACPI Devel Maling List
Subject: Re: [ACPI] utmisc-0131: *** Error: Invalid owner_id: 00

[skipped]
Last question: what am I doing wrong in the following?
# acpidump -o dsdt.dat
# iasl -d dsdt.dat

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050624 [Aug 24
2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

Loading Acpi table from file dsdt.dat
TableHeader length [0x30204020] greater than the input file size
[0x14CF9]
Could not get table from the file
#

--=20
mattia
:wq!


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
