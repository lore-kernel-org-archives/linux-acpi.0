From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Missing AML_REF_OF_OP case in exoparg1.c
Date: Wed, 28 Aug 2002 15:24:29 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B72A@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "'KOCHI, Takayoshi'" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I'll add this for the next release, hopefully tomorrow.

Good catch,
Thanks,
Bob


-----Original Message-----
From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org] 
Sent: Wednesday, August 28, 2002 2:07 PM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Missing AML_REF_OF_OP case in exoparg1.c

Hi,

The aml generated from this source will generate error message
as follows (using 20020815 core, subtype 71 = AML_REF_OF_OP):

exoparg1-0604: *** Error: Acpi_ex_opcode_1A_0T_1R/Type_op: Unknown Reference
subtype 71
 psparse-1155: *** Error: Method execution failed, AE_AML_INTERNAL

DefinitionBlock ("test.aml", "DSDT", 1, "XXX   ", "AAAAA   ", 0)
{
	Scope (\_SB)
	{
		Method (XXXX)
		{
			Store ("String", Local0)
			Store (ObjectType (RefOf(Local0)), Local1)

			Store (0x1234, Local0)
			Store (ObjectType (RefOf(Local0)), Local2)
		}
	}
}

In acpi_ex_opcode_1A_0T_1R()'s ObjectType (AML_TYPE_OP) case,
it misses the AML_REF_OF_OP case in its switch statement.

The spec says that "Notice that if this operation is performed on an
object reference such as one produced by the Alias, Index, or RefOf
statements, the object type of the base object is returned" (16.2.3.4.2.37).

Bob, could you fix this?

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
