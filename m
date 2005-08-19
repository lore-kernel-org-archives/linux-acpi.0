From: Avuton Olrich <avuton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Asus A7N8X not resuming with 2.6.13-rc6-mm1, worked with 2.6.13-rc5-mm1
Date: Fri, 19 Aug 2005 11:37:41 -0700
Message-ID: <3aa654a4050819113778c4d4b0@mail.gmail.com>
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
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello,

My Asus A7N8X worked previously with the 2.6.13-rc5-mm1, as was the
subject of the thread:

http://marc.theaimsgroup.com/?t=3D112339603900001&r=3D1&w=3D2

and the bugzilla bug:

http://bugzilla.kernel.org/show_bug.cgi?id=3D4723

With linux-2.6.13-rc6-mm1 resume has stopped working again. For any
information you need to know about the system, I put very verbose logs
at the bugzilla link and they are all still valid.

What happens is:
Here's my script to sucessfully shutdown and resume in 2.6.13-rc5-mm1,
all of the following must be done with X stopped and the nvidia module
unloaded.

# sync
# echo "mem" > /sys/power/state
# vbetool post

And like magic it just works.

What happens with 2.6.13-rc6-mm1:

(the 3 lines from before), I can ping the machine for 8 seconds, (I
could probably ssh into it if I were quick) then I can hear the
harddrives stop and the computer and power supply continue to run as
if it went into standby (echo standby > /sys/power/state). I see no
messages in the syslog.

How can I help?

thanks,
avuton

--=20
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
