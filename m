From: "David Mathog" <mathog-Mlb+9xX7RBA8OKIjkCRLjtKIQNXEaThN@public.gmane.org>
Subject: Save power at idle onTyan S2466N-MPX, athcool, etc.
Date: Sun, 02 Oct 2005 11:29:15 -0700
Message-ID: <E1EM8aJ-0002nI-00@mendel.bio.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I'm currently on a quest to reduce the idle power
usage on various machines here.  For instance, using
"athcool" on a 2.6.11-12mdk kernel (Mandriva 2005LE)
on some Asus A7V266E machines it was possible to drop
the idle temps from 57.5C to 39C.

Flushed with success from that I next tried athcool
on a single processor (athlon-MP 2200+) Tyan 2466N-MPX
using a 2.6.8.1 kernel.  No joy.  It claimed to have
changed the bits it controls but this didn't do a thing
to the idle CPU temperature.  Neither did turning those bits
off, so it wasn't already in the low power state.

This gives a pretty good clue why:

%  modprobe processor
%  cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no

/proc/acpi/processor/CPU0/power
showed that only C1 was supported.  On the ASUS boards both C1 and
C2 were present.

So my question is, has anybody managed to get the Athlon's 
"power saving at idle" mode working  on this board?  If so,
which BIOS settings, kernel, modules, and other magic was
needed to do so?  

Thanks,

David Mathog
mathog-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org
Manager, Sequence Analysis Facility, Biology Division, Caltech



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
