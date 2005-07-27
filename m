From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI buttons in 2.6.12-rc4-mm2
Date: Wed, 27 Jul 2005 19:40:46 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300428CAA6@hdsmsx401.amr.corp.intel.com>
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
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: thecwin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20
>> I'm open to suggestions on how to approach this transition.
>> I can make ACPI_PROC a static build option -- what else
>> can I do to ease the transition in this, our stable release?
>
>Well I don't know how awkward this would be from an=20
>implementation POV, but can we just leave the legacy
>/proc stuff there until the /sys interface is
>all in place and userspace is upgraded?
>Then kill all the /proc stuff later?
>
>We could also print a rude message the first time someone=20
>tries to use a deprecated /proc file, just to help push the
>userspace tool developers along.
>Although I note that sys_bdflush() is still with us ;)

/proc/acpi/event
/proc/acpi/sleep
are used the most.

/proc/acpi/<drivername>/<BIOS devname>/* are really screwed up
in that <BIOS devname> is an arbitrary internal BIOS string
that should have never been exposed to userspace.  Instead
we should have done what sysfs does -- look at the _type_
of device and then simply add a number to it -- cpu0, cpu1
so that a program could actually find stuff.

I'm constantly nagged that this layer in the /proc/tree
had arbitrary strings in pathnames.  Also, the /proc
file handling code is buggy -- so it wastes my time
maintaining it, when it should not exist at all...
Restoring the /proc code to the button driver will
increase button.c in size by over 60%...

So I'm in favor of whatever solution makes it all go away
as soon as possible.

-Len


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
