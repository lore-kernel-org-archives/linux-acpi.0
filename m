From: Christian Zoz <zoz-l3A5Bk7waGM@public.gmane.org>
Subject: Re: DSDT in initrd
Date: Tue, 20 May 2003 17:37:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030520153754.GG24453@suse.de>
References: <F760B14C9561B941B89469F59BA3A84725A2A7@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

On Fri, May 16, Grover, Andrew wrote:
> 
> It should be obvious that using DSDT override (however easy we make it)
> is NOT an option for distributions or any sort of non-developer
> solution. You mention that distributions could install DSDTs on
> installation but I don't buy it. This is part of the reason that I
> haven't been very receptive towards making DSDT override very easy.

Distributors cannot ship fixed DSDTs. That would be to much work. But
there are a lot of Linux Newbies with a laptop that worked so far with
W*. Now they are going to try Linux and get ACPI troubles.
It's far easier to explain them to place a fixed DSDT in a certain
file and to call mkinitrd than to guide them trough a kernel
complilation and installation.
Life would be ways easier for supporters. 

There are people wich benefit from this patch.
Does this patch harm on the other side?

> We need to look for solutions that make using an ACPI-enabled kernel
> possible on the widest number of machines possible, *without* involving
> DSDT override. If there are bugs in the interpreter, we need to fix
> them.

Yes.

> If there are bugs in the DSDT, we need to get on OEMs to fix them.

Yes.

> Or, we need to have a blacklist that, either via specific system
> signatures or just BIOS date, safely reverts to non-ACPI on machines on
> which it has problems.

You cannot always revert to non-ACPI without losing funcionality.

At this point the average private laptop user is left alone. Why don't
we help him to fix his buggy DSDT?

> I really think it's kind of funny that so many people on this mailing
> list have gotten so good at fixing their systems' DSDT (maybe they
> should apply for BIOS engineer jobs!)

Wonderfull! This maybe helps to come to more sophisticated BIOS
engineer and thus better BIOSs. ;)))

> but this skill is the equivalent of requiring someone to know how an
> engine works in order to drive a car.

Sometimes i were glad i could fix the programming of my bordcomputer
myself.

-- 

ciao, christian

  --------------------------------------------------------------------
    Verglichen mit jedem x-beliebigen Redmonder Betriebssystem-Clone
    ist Linux geradezu eine leuchtende Perle der Datensicherheit.
  ------ Frank Rennemann (http://www.linux-knowledge-portal.org) -----


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
