From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Masquerading operating systems (with ACPI_OS_NAME) does cause grief.
Date: Mon, 10 Jan 2005 10:41:03 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E3901D5@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Barry Kitson <b.kitson-EkmVulN54Sk@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Another thing to keep in mind is that on many, many machines, "Microsoft
Windows NT" or similar is essentially the only tested code path.



> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Bruno Ducrot
> Sent: Monday, January 10, 2005 7:03 AM
> To: Barry Kitson
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Masquerading operating systems (with ACPI_OS_NAME)
> does cause grief.
>=20
> On Sun, Jan 09, 2005 at 11:40:52PM +1000, Barry Kitson wrote:
> > The following messages ....
> > http://sourceforge.net/mailarchive/message.php?msg_id=3D9558174
> > http://sourceforge.net/mailarchive/message.php?msg_id=3D9559475
> > suggest that there are no known problems resulting from pretending
your
> > favourite OS is something it's not.  Well, bad news.....
> >
> > Please note that (modulo VGA, which has it's own special set of
> > problems) the only string (prefix) that causes suspend/resume of
linux
> > 2.6.10 to fail on a VIA EPIA CL10000 Mini-ITX motherboard (with
either
> > of the two available BIOS versions - 1.16 or 1.23) is the newish
(but
> > not entirely accurate) default of ACPI_OS_NAME=3D"Microsoft Windows
NT".
> > When Linux declares itself to be NT, resumes just don't happen.  The
fan
> > and power supply wake up, but that's about all.
> >
> > Are we really sure this value of ACPI_OS_NAME should be the default?
> > Could I suggest a return to "truth" as a default, with prominent
> > suggestions within the documentation of what lies to try when the
truth
> > fails?
>=20
> Was done by testing by Bob IIRC and showed that this give less errors
> than having set it to "Linux".  "Linux" is not present for all DSDT
Ive
> seen so far (well, actually Ive seen a IBM laptop, don't remember the
> model though).  It's then good to atleast set _OS to "something well
> knows".
>=20
> It turns out that "Microsoft Windows NT" is for now "better", but this
> may be not true for everybody.
> Note also that ACPICA support the _OSI stuff, so its not Windows NT
but
> another Windows IIRC (I don't remember which one).
>=20
> You may therefore try to pass the kernel option "acpi_osi=3D"
> to see if that's help (especially if a grep _OSI file.asl is positive)
> before overriding acpi_os_name.
>=20
>=20
> --
> Bruno Ducrot
>=20
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
>=20
>=20
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
