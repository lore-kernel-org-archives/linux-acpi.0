From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: presario 1505us battery not found
Date: Mon, 28 Apr 2003 10:51:39 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3C2B@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Abheek Anand <abheek-VX+DGZyGJwM3uPMLIKxrzw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The problem with the AE_NOT_EXIST message during EC access is as
follows:

The _INI method for the EC device is inappropriately accessing the EC
hardware before the EC driver has been loaded.  This is because the _INI
method is accessing the hardware before the _REG method has been run on
the EC Operation Region(s).  The _REG method is only run once the EC
driver has been loaded and has installed a handler for the EC GPE.

Relevant sections of the ACPI specification are included below.

Since the ASL for this machine is violating the _REG protocol so
blatantly, I'm afraid that this BIOS will have to blacklisted until it
is fixed by the vendor.

Bob

Section 6.5.1: (_INI) 

The _INI method must only access Operation Regions that have been
indicated to available as defined by the _REG method.

Section 6.5.4:  (_REG)

Except for the cases shown below, control methods must assume all
operation regions inaccessible until the _REG(RegionSpace, 1) method is
executed. Once _REG has been executed for a particular operation region,
indicating that the operation region handler is ready, a control method
can access fields in the operation region. Conversely, control methods
must not access fields in operation regions when _REG method execution
has not indicated that the operation region handler is ready.

For example, until the Embedded Controller driver is ready, the control
methods cannot access the Embedded Controller. Once OSPM has run
_REG(EmbeddedControl, 1), the control methods can then access operation
regions in Embedded Controller address space. Furthermore, if OSPM
executes _REG(EmbeddedControl, 0), control methods must stop accessing
operation regions in the Embedded Controller address space.

The exceptions for this rule are:
1.	OSPM must guarantee that the following operation regions must
always be accessible:
*	PCI_Config operation regions on a PCI root bus containing a _BBN
object.
*	I/O operation regions.
*	Memory operation regions when accessing memory returned by the
System Address Map reporting interfaces.
2.	OSPM must make Embedded Controller operation regions, accessed
via the Embedded  Controllers described in ECDT, available before
executing any control method. These operation regions may become
inaccessible after OSPM runs _REG(EmbeddedControl, 0).


> -----Original Message-----
> From: Moore, Robert
> Sent: Friday, April 25, 2003 2:54 PM
> To: Abheek Anand; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] presario 1505us battery not found
> 
> 
> We are still looking at the problems.
> 
> 1) The AE_ALREADY_EXISTS problem has been around for a while and we've
> finally figured it out.  It turns out that it does not adversely
affect
> anything, but we are fixing it.
> 
> 2) The AE_NOT_EXIST message means that the EC driver is not up and
> running yet.  We are still investigating this.
> 
> Bob
> 
> 
> > -----Original Message-----
> > From: Abheek Anand [mailto:abheek-VX+DGZyGJwM3uPMLIKxrzw@public.gmane.org]
> > Sent: Thursday, April 24, 2003 12:50 PM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: [ACPI] presario 1505us battery not found
> >
> > Hi,
> >
> > After quite a bit of tinkering with my presario 1505us, I managed to
> get
> > most
> > of what I need up and working. Currently im using linux 2.5.67 with
> > acpi-20030328. I am able to get ac-adaptor information, and the LID
> works
> > fine. However, I am unable to get acpi to recognize my battery,
which
> it
> > always shows as absent. I have looked at several people's
suggestions
> on
> > this
> > on the mailing list, but none of them work for me.
> >
> > I'm including a copy of the dmesg messages my system spews out. I
also
> did
> > the
> > usual dsdt disassemble, fix, and include in kernel routine. I have
put
> up
> > my
> > original (and fixed) dsdt on http://www.cs.umd.edu/~abheek/acpi . My
> > /proc/acpi/battery/BAT1 entries show the battery as absent.
> >
> > Any help would be _very_ appreciated.
> >
> > Thanks,
> > Abheek
> >
> >


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
