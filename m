From: Theodore Morse <ender5175-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: RedHat 8.0 Toshiba and other things
Date: Fri, 20 Dec 2002 19:38:46 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021221033846.16606.qmail@web13708.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello:

I recently bought a Toshiba Satellite 1905-S303, and
successufully installed RedHat 8.0 on it. However, I
was concerned to find that it did not support the APM
protocol, but instead the APCI. After updgrading my
kernel 2.4.19-3, and compiling it with ACPI, it
registred my battery finally. However, it works to a
point. First, I can do a:
cat /proc/acpi/battery/1/status
twice with no hitches. However, the third time it
gives me this:
% cat /proc/acpi/battery/1/status
Present:                 yes
Error reading battery status (_BST)

This happens every time. I am not quite sure what to
do about it. Any suggestions would be appreciated.

I am also curious as to whether the patches on your
website work 'only' for the kernels mentioned, or they
can be applied to other versions. For instance, could
I apply the 2.4.20 patch to a 2.4.19 kernel, as in my
case?

Last, I am interested in writing a GTK-panel app that
would act as a battery monitor, but not sure how to
tap into the information acpi provides. Is there any
documentation on how this could be achieved. I 'could'
just get the info from the files in /proc, but I fear
that is not the way to go. Furthermore, with my
aformentioned problem, it would only work on the first
two queries.

Any help would be greatly appreciated.

Thanks,
Ted Morse

=====
Ted Morse
Student/Programmer
University of Evansville/Ciholas Enterprises

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
