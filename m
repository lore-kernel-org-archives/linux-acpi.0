From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: utmisc-0131: *** Error: Invalid owner_id: 00
Date: Wed, 24 Aug 2005 14:51:38 +0400
Message-ID: <6694B22B6436BC43B429958787E454983CB7B8@mssmsx402nb>
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
To: Mattia Dongili <malattia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: ACPI Devel Maling List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Mattia,

Thanks for helping with this issue...
There are can be two causes to this -- we either overwrite allocated
owner_id (this can be checked with the WARN_ON (owner_id !=3D 0)
in acpi_ut_allocate_owner_id -- we never copy owner_id) or we give just
released owner_id location instead of right one to release_owner_id
function.
Could you please try suggested check in acpi_ut_allocate_owner_id ?
Also it can be extremely helpful if you can print the name of the AML
method there this fault accurs, for this you need to turn the check
above into return error code.

Thanks again,
	Alex.



-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Mattia
Dongili
Sent: Sunday, August 21, 2005 9:42 PM
To: Thomas Renninger
Cc: ACPI Devel Maling List
Subject: Re: [ACPI] utmisc-0131: *** Error: Invalid owner_id: 00

On Sat, Aug 20, 2005 at 07:13:42PM +0200, Thomas Renninger wrote:
> Mattia Dongili wrote:
> > On Thu, Aug 18, 2005 at 08:21:53PM +0200, Mattia Dongili wrote:
> >>Hello,
> >>
> >>I'm seeing the error (almost randomly and at with a varying
frequence)
> >>utmisc-0131: *** Error: Invalid owner_id: 00
> >>
> >>It seems completely harmless but after some hours of work however
this
> >>other related warning appears when reading the battery state:
> >>psparse-0509: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC
> >>0_.ACAD._PSR] (Node c126e7c8), AE_OWNER_ID_LIMIT

I found a place where the Invalid owner_id error always happens and
added a WARN_ON.
Also, adding a couple of printks to track IDs I had:

[...]
  Checking 'hlt' instruction... OK.
  Allocated: 1
  Allocated: 2
  Allocated: 3
  Allocated: 4
  Allocated: 5
   tbxface-0109 [02] load_tables           : ACPI Tables successfully
acquired
  Parsing all Control Methods:.
  <4>Allocated: 6
  Released: 6

6 is then allocated and released 190 times

  Table [DSDT](id 0005) - 555 Objects with 54 Devices 191 Methods 21
Regions
  ACPI Namespace successfully loaded at root c03cf5b8
  evxfevnt-0091 [03] enable                : Transition to ACPI mode
successful
  NET: Registered protocol family 16
  ACPI: bus type pci registered
  PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=3D2
  PCI: Using configuration type 1
  ACPI: Subsystem revision 20050729
  evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs
on int 0x9
  evgpeblk-0996 [06] ev_create_gpe_block   : Found 6 Wake, Enabled 0
Runtime GPEs in this block
  evgpeblk-0988 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs
on int 0x9
  evgpeblk-0996 [06] ev_create_gpe_block   : Found 1 Wake, Enabled 0
Runtime GPEs in this block
  Allocated: 6
  Allocated: 7
  Released: 7
  Allocated: 7
  Released: 7
  Released: 0
------------^
should this be 6?
6 is never allocated anymore.

    utmisc-0133: *** Error: Invalid owner_id: 00
  Badness in acpi_ut_release_owner_id at
drivers/acpi/utilities/utmisc.c:134
   [<c021766a>] acpi_ut_release_owner_id+0x75/0x11d
   [<c01f6df7>] acpi_ds_terminate_control_method+0x187/0x1d0
   [<c020e9d6>] acpi_ps_parse_aml+0x1aa/0x2e4
   [<c020fea0>] acpi_ps_execute_pass+0xa9/0xd5
   [<c020fd30>] acpi_ps_execute_method+0x104/0x195
   [<c020b5f9>] acpi_ns_execute_control_method+0x10b/0x132
   [<c020b4b5>] acpi_ns_evaluate_by_handle+0x104/0x13d
   [<c01f9caf>] acpi_ev_execute_reg_method+0x12f/0x16a
   [<c020d8f8>] acpi_ns_walk_namespace+0xbb/0x1b7
   [<c01fa65c>] acpi_ev_execute_reg_methods+0x3b/0x5f
   [<c01fa680>] acpi_ev_reg_run+0x0/0x50
   [<c01f9b4d>] acpi_ev_initialize_op_regions+0x5b/0x8e
   [<c02181a8>] acpi_initialize_objects+0x4e/0x132
   [<c038c8f2>] acpi_bus_init+0x40/0xe5
   [<c038ca11>] acpi_init+0x7a/0x11e
   [<c037c914>] do_initcalls+0x54/0xd0
   [<c03941ea>] netfilter_init+0x9a/0xd0
   [<c01002a0>] init+0x0/0x170
   [<c01002cf>] init+0x2f/0x170
   [<c0101394>] kernel_thread_helper+0x0/0xc
   [<c0101399>] kernel_thread_helper+0x5/0xc
  Completing Region/Field/Buffer/Package
initialization:.........................................................
.....
  Initialized 20/21 Regions 0/0 Fields 25/25 Buffers 17/27 Packages (564
nodes)
  Executing all Device _STA and_INI methods:....<4>Allocated: 7
  Released: 7
  .............<4>Allocated: 7
  Released: 7
  Allocated: 7
  Allocated: 8
  Released: 8
  Released: 7
 =20
I'm going through the code trying to follow possible paths but it'll
take long :) so I'm sharing these thoughts.

--=20
mattia
:wq!


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle
Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing &
QA
Security * Process Improvement & Measurement *
http://www.sqe.com/bsce5sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
