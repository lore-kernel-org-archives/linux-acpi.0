From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Userspace ACPI interpreter
Date: Thu, 28 Oct 2004 14:42:18 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05502764B4F@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Theodore Ts'o <tytso-3s7WtUTddSA@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Therien, Guy" <guy.therien-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I've been working on the ACPI CA project for over 6 years, and trust me,
this has been tried before.  There are significant reasons for having
the interpreter in the kernel.

You don't really want to page out the interpreter when you are using it
for things like suspend/resume, thermal control, and many other things.

I think we have a list around somewhere with many of the reasons, I will
look for it.

Bob


> -----Original Message-----
> From: Theodore Ts'o [mailto:tytso-AKGzg7BKzIDYtjvyW6yDsg@public.gmane.org] On Behalf Of Theodore
Ts'o
> Sent: Thursday, October 28, 2004 8:24 AM
> To: Brown, Len
> Cc: Yu, Luming; Bjorn Helgaas; Moore, Robert; Alex Williamson; linux-
> kernel; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC]
dev_acpi:
> support for userspace access to acpi)
>=20
> On Thu, Oct 28, 2004 at 01:37:52AM -0400, Len Brown wrote:
> > One way to experiment with a user-mode ACPI interpreter would be to
> > continue to use the kernel-mode interpreter for boot up , and cut
over
> > to the user-mode interpreter at /sbin/init.  The kernel-mode
interpreter
> > could be sent the way of free_initmem() which is called just before
> > /sbin/init is invoked.
>=20
> Is there a significant advantage to doing having a user-mode ACPI
> interpreter?  The only advantage I can think of is that the ACPI
> interpreter could now live in pageable memory.  Are there any others?
>=20
> 					- Ted


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
