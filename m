From: Filippos Klironomos <presariod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ACPI not working as expected after kernel-2.6.10-1.771_FC2 upgrade in Compaq Presario 2500
Date: Sun, 5 Jun 2005 18:33:45 -0400
Message-ID: <5844a3ae050605153331fb6fc9@mail.gmail.com>
Reply-To: Filippos Klironomos <presariod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello list,

I have recently upgraded my kernel to 2.6.10-1.771_FC2 and after that
my ACPI stopped working as it had in all previous kernel versions. The
battery state is not updated in /proc/acpi/battery regularly, the
brightness of the screen does not change immediately when I press the
Fn+f1(f2) combination but it lags behind. In other words I have to
repeatedly press the combination in order for previous presses to take
effect. If I unplug the AC there is no change in
/proc/acpi/ac_adapter.

Generally speaking interupt requests involving ACPI are either lost or
delayed for some reason.

Under this kernel I had for the first time to put 'acpi=3Dnopci' on the
command line do avoid interrupt conflicts.

Any help would be greatly appreciated! For the record I compiled my
own version of 2.6.10-1.771_FC2 where APM is explicitly turned off and
all ACPI related support is compiled into the kernel instead of being
modular (just in case) and the problem persists.

Thank you,
Filippos


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
