From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Various ACPI-Problems on Tecra S1
Date: Thu, 4 Dec 2003 11:29:27 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720BF5@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Holzt <kju-+hGXy1KyAyQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm interested in the error about "no handler for region", We have =
resolved one similar issue (please refer to =
http://bugme.osdl.org/attachment.cgi?id=3D1361&action=3Dview=20
And latest ACPI CA has included this kind of fix.)  Would you please =
file your issue on bugzilla.kernel.org to help us to tracker.
Thanks=20
Luming

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Michael =
Holzt
Sent: 2003?11?23? 3:04
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Various ACPI-Problems on Tecra S1


I own a Toshiba Tecra S1 Notebook. This notebook seems to have a.) a =
broken
DSDT table (seems not so uncommon) and b.) some other problem with ACPI.
Maybe somebody can help me figure this out.

My decompiled DSDT Table is available at =
http://www.kju.de/data/dsdt.dsl.
Intels Compiler iasl complains about some errors in the table:

a.) (three different times)

    dsdt.dsl   708:    Notify (\_TZ, 0x80)
    Error    1035 -    Invalid type ^  ([Resource] found, Notify =
operator=20
                       requires [Device|Processor|Thermal])

b.) (five different times)

    dsdt.dsl  3742:    /*** Missing EndDependentFunctions descriptor */ =
})
    Error    1071 -    Missing EndDependentFn() macro in dependent=20
                       resource list                                    =
^

But i guess this errors are not related to by main problem, which is =
that i
get not battery status. Kernel states when loading:

evregion-0249 [22] ev_address_space_dispa: no handler for =
region(c12f46c8)=20
              [EmbeddedControl]
 exfldio-0282 [21] ex_access_region      : Region EmbeddedControl(3) has =
no=20
              handler
 dswexec-0422 [14] ds_exec_end_op        : [Store]: Could not resolve=20
              operands, AE_NOT_EXIST
 psparse-1120: *** Error: Method execution failed [\_SB_.BAT0._STA] =
(Node=20
              c12fc9e8), AE_NOT_EXIST

(Same Error repeats with same hexnumbers for \_SB_.BAT1._STA].

I get two similar problems for the Docking Interface, but having the =
battery
fixed has more priority. I already googled (web+news) for problems like =
this
and searched mailing lists, but i found only other people with likewise
error messages but no information about causing reasons and how to fix
problems like this.

I can supply more information if asked for and/or run test programs. Any
help appreciated.=20


Regards
Michael

--=20
Michael Holzt, DL3KJU, kju-+hGXy1KyAyQ@public.gmane.org, kju@debian.org, kju@IRCNet


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
