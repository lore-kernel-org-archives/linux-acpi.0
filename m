From: "Shridhar GR" <Shridhar_GR-MyfdzN0ulLNWk0Htik3J/w@public.gmane.org>
Subject: System Hangs with ACPI support enabled in Kernel 2.4.21
Date: Mon, 29 Dec 2003 13:44:08 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E125980C421DFD4DA0B80D55DB1EDA58018FB2A3@mtv01ex01.mindtree.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hi

	I have problem in Shutting down the system with ACPI support enabled.
I am using kernel 2.4.21. System is configured for RAID1 . I have =
installed
ACPI daemon. When I press the hardware button, the system goes for =
proper
shutdown but hangs with a dispay "flushing ide device: hda hdb hdd Power
down." I am using "shutdown -h now" command. Even "halt", "poweroff" and
"shutdown" command does not work from command line too. Please guide me =
solve
this problem. I have not applied any extra ACPI patch to the kernel. I =
have
configured the existing ACPI parameters as below

[*] Power Management support

[*]   ACPI support

[ ]     ACPI Debug Statements
<*>     ACPI Bus Manager
<M>       System             =20
<M>       Processor

<M>       Button

< >       AC Adapter

<*>       Embedded Controller

< >       Control Method Battery

< >       Thermal

< >   Advanced Power Management BIOS support=20

   								=09
=09

Please suggest a solution for this.

Thank u
Best Regards
Shridhar
 =20




DISCLAIMER:
This message (including attachment if any) is confidential and may be =
privileged. Before opening attachments please check them for viruses and =
defects. MindTree Consulting Private Limited (MindTree) will not be =
responsible for any viruses or defects or any forwarded attachments =
emanating either from within MindTree or outside. If you have received =
this message by mistake please notify the sender by return  e-mail and =
delete this message from your system. Any unauthorized use or =
dissemination of this message in whole or in part is strictly =
prohibited.  Please note that e-mails are susceptible to change and =
MindTree shall not be liable for any improper, untimely or incomplete =
transmission.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
