From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: DSDT in initrd
Date: Fri, 16 May 2003 18:17:54 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96EA0@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Cc: mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Randy.Dunlap [mailto:rddunlap-3NddpPZAyC0@public.gmane.org]=20
> Lots of newer systems don't have an option of "... safely reverts to
> non-ACPI ...", and surely you know that.  It's make ACPI work in some
> fashion or have no power management.

Yeah but DSDT in initrd doesn't help solve the problem for anyone but
hackers.

> It seems that your goal is idealistic and not user-friendly, at least
> not in the short-term.  It's a worthy long-term goal.

Anything that does not use the DSDT from the BIOS is not user-friendly.
It should "just work" for as many people as possible, without hackery.
It's never going to be 100%. The only way I can think of to get close is
if we take the time to implement a cutoff based on BIOS date, with both
a Good and Bad BIOS list, for exceptions to that cutoff.

I must admit I'm really torn. If there were 2-3 little AML problems that
if we worked around them, a horde of machines would start working, then
I think we would do that, but my sense is that there are many more ways
a DSDT can be broken, and that implementing workarounds for all of them
would cause other systems to fail. Maybe some of the people who have
fixed their DSDTs can comment on the scope of bugs out there.

> The ACPI interpreter will always have bugs in it.  The BIOS DSDTs
> will always have bugs.  After all, they are software (or firmware).

All I can say w.r.t. bugs is that it used to be the case that when
diagnosing an issue, I started with the assumption the BIOS was right
and the interpreter had a bug -- now I start with the assumption that
the BIOS is buggy. :) If we can come up with a solution to mitigate the
impact of bad DSDTs, then in my mind the only things left are 1)
squashing the few bugs left in the PCI IRQ routing code and 2) sleep
support. We've come a long way baby!

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
