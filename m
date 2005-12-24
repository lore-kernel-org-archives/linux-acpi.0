From: <cthulhufhtagn-nvIDUHlZTd3QT0dZR+AlfA@public.gmane.org>
Subject: Need some help with Toshiba L20-101 DSDT table
Date: Sat, 24 Dec 2005 01:33:10 -0700
Message-ID: <20051224083310.C9DA75C002D@webmail3.spymac.net>
Reply-To: cthulhufhtagn-nvIDUHlZTd3QT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm geting this four errors which I suppose are caused by that objects bein=
g=0D
defined before (never heard about the "ACPI language" 'till today).=0D
----------------=0D
# ./iasl -tc dsdt.dsl=0D
=0D
Intel ACPI Component Architecture=0D
ASL Optimizing Compiler / AML Disassembler version 20030228 [Feb 28 2003]=
=0D
Copyright (C) 2000 - 2003 Intel Corporation=0D
Supports ACPI Specification Revision 2.0b=0D
=0D
dsdt.dsl   370:             If (LEqual (And (PDC0, 0x0A), 0x0A))=0D
Error    1022 -           Object does not exist ^  (PDC0)=0D
=0D
dsdt.dsl   375:             If (LEqual (And (PDC1, 0x0A), 0x0A))=0D
Error    1022 -           Object does not exist ^  (PDC1)=0D
=0D
dsdt.dsl  3936:                 Z003,=0D
Error    1022 -                    ^ Object does not exist (Z003)=0D
=0D
dsdt.dsl  3937:                 Z003,=0D
Error    1022 -                    ^ Object does not exist (Z003)=0D
=0D
ASL Input:  dsdt.dsl - 4240 lines, 137275 bytes, 1880 keywords=0D
Compilation complete. 4 Errors, 0 Warnings, 0 Remarks, 546 Optimizations=0D
------------------=0D
=0D
I fixed the Z003 deleting that two entries, which I think is tricky. Couldn=
't fix=0D
the PDCs after researching on Google for almost an hour. This are the fragm=
ents=0D
of code:=0D
=0D
-------------------=0D
    Method (PNOT, 0, Serialized)=0D
    {=0D
        If (HTTE)=0D
        {=0D
            If (LEqual (And (PDC0, 0x0A), 0x0A))=0D
            {=0D
                Notify (\_PR.CPU0, 0x80)=0D
            }=0D
=0D
            If (LEqual (And (PDC1, 0x0A), 0x0A))=0D
            {=0D
                Notify (\_PR.CPU1, 0x80)=0D
            }=0D
        }=0D
        Else=0D
        {=0D
            Notify (\_PR.CPU0, 0x80)=0D
            Sleep (0x64)=0D
            Notify (\_PR.CPU0, 0x81)=0D
        }=0D
    }=0D
---------------------=0D
=0D
And:=0D
=0D
---------------------=0D
        Device (BAT1)=0D
        {=0D
            Name (_HID, EisaId ("PNP0C0A"))=0D
            Name (_UID, 0x01)=0D
            Name (CBTI, 0x00)=0D
            Name (PBTI, 0x00)=0D
            Name (BTIN, 0x00)=0D
            Name (BTCH, 0x00)=0D
            Name (BIFI, 0x00)=0D
            Name (SEL0, 0x00)=0D
            Name (BCRI, 0x00)=0D
            Name (PBIF, Package (0x0D)=0D
            {=0D
                0x01,=0D
                0x1130,=0D
                0x1130,=0D
                0x01,=0D
                0x2B5C,=0D
                0x012C,=0D
                0x84,=0D
                0x20,=0D
                0x20,=0D
                "PA34200-1BRS",=0D
                "11        ",=0D
                "11        ",=0D
                "TOSHIBA   "=0D
            })=0D
            Name (PBST, Package (0x04)=0D
            {=0D
                0x00,=0D
                Z003,=0D
                Z003,=0D
                0x2710=0D
            })=0D
            Name (ERRC, 0x00)=0D
            Name (_PCL, Package (0x01)=0D
            {=0D
                \_SB=0D
            })=0D
--------------------=0D
=0D
I'm not sure about I'm giving enough info, and didn't think posting the who=
le=0D
archive was very polite.=0D
=0D
Has anyone a idea on how to fix it? If you need the full *dsl to give me so=
me=0D
advice, tell me and I'll send it off the list. I'm starting to learn C, so =
please=0D
don't blame me for not knowing how to programm in such a low level thingy. =
I=0D
would appreciate it if you could give me some links to an introduction to "=
ACPI=0D
programming", too.=0D
=0D
Thank you very much!=0D


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
