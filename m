From: Joseph N. Hall <joseph-0mWiNuHK5VbQT0dZR+AlfA@public.gmane.org>
Subject: ACPI patch on Fiva MPC-206e
Date: Fri, 20 Sep 2002 18:10 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E17sYl5-0006LQ-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dear ACPI Developers,

No, I haven't done it yet but I will give it a try soon!  Perhaps/probably
this weekend.

ACPI (and APM) is totally broken on the MPC-206e.  It is always
"AC online, no battery," doesn't get the buttons right, doesn't
hibernate (should have hibernate partition support ...?), doesn't
know about power state.  So I am anxious to see whether there are
any improvements, because they would be useful to me.

I have the factory BIOS.  I believe there is an upgrade available
for the 205/206 but it is all Japanese and I am not going to proceed
without a translation and instructions. :-/

I am running 2.4.19-ac4 on rh 7.3 at present, works fine in general.
I didn't read all the details about the patch but it appears it should
be applied to 2.4.20.  (Which I have had IDE problems with on other
machines, of course.)  Let me know if you have any further advice.

  -joseph

  Joseph N. Hall
  Author, Effective Perl Programming



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
