From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: RE: DSDT in initrd
Date: Sat, 17 May 2003 11:30:38 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0305171107090.2192@tweety.gaugusch.at>
References: <F760B14C9561B941B89469F59BA3A84725A2A7@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A2A7-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On May 16, Grover, Andrew <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> It should be obvious that using DSDT override (however easy we make it)
> is NOT an option for distributions or any sort of non-developer
> solution. You mention that distributions could install DSDTs on
> installation but I don't buy it. This is part of the reason that I
> haven't been very receptive towards making DSDT override very easy.
I think that no distribution will deliver fixed DSDT's, but people can
download them from acpi.sf.net, or ask people here to fix them.
More and more people are using distribution kernels, and it is hard for
them to compile their own. If we can implement an easy solution to solve
severe problems (and a broken DSDT is something that WILL lead to severe
problems in many cases), we should do it.

> We need to look for solutions that make using an ACPI-enabled kernel
> possible on the widest number of machines possible, *without* involving
> DSDT override.
Of course we should do this, but this doesn't mean that there should not
be alternatives.

> If there are bugs in the DSDT, we need to get on OEMs to fix them.
As I said, I fixed the DSDT four year old compaq laptop a few weeks ago,
to get battery status and other things that a user expects to get from a
laptop. No vendor will provide updates for machines being that old.

> Or, we need to have a blacklist that, either via specific system
> signatures or just BIOS date, safely reverts to non-ACPI on machines on
> which it has problems.
ACPI has many benefits, and linux users usually like to get the last out
of their machines. There are old machines supporting ACPI, and we should
support them, even if the default DSDT is broken.

> I really think it's kind of funny that so many people on this mailing
> list have gotten so good at fixing their systems' DSDT (maybe they
> should apply for BIOS engineer jobs!) but this skill is the equivalent
> of requiring someone to know how an engine works in order to drive a
> car.
Many people with old (or sometimes even new!) cars have to go to an
engineer to get it fixed.  Sometimes even for free, if you have good
friends :)

Markus
-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
