From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: How to support new buttons?
Date: Mon, 2 Dec 2002 12:39:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021202123935.4df753c1.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi all!
First off: Many thanks for your big efforts on getting ACPI into Linux!
ACPI is not at all easy (from what I have seen now) and it is a lot of
work. I appreciate this very much.

So. And now that I own a brand new laptop which only works partially
with ACPI I would like to help a little. As a small first task I would
like to support the additional buttons I have here which very obviously
cause ACPI events. The machine I am talking about is an Asus L3800C.
This machine has four hotkey on top of the keyboard. One is supposed to
be a speedstep control button, on is "email" (what nonsense :), and the
other two have some strange symbols on them (no idea what they are
supposed to be good for). When I enable ACPI debugging I can see that
"something" happens when I press those buttons and this "something" is
different for all four of them. Oh, and ACPI interrupt is triggered on
press. But /proc/acpi/event does not show an event.
I suspect that those buttons are simply not supported by the button
driver yet. Looking at button.c I see that only power, sleep and lid are
supported.

So, how can I add support for those additional buttons?
Oh, I don't expect a detailed a full answer. Just a pointer for an ACPI
newbe please :)

CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
