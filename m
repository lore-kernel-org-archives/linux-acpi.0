From: =?iso-8859-1?q?Gustavo=20Sverzut=20Barbieri?= <gsbarbieri-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Subject: Newbie questions
Date: Sat, 3 Aug 2002 01:10:40 -0300 (ART)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020803041040.10310.qmail@web20904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I'm a newbie to ACPI (just bought a
desknote(www.desknote.biz) laptop that ships w/ that).
I'm trying to use ACPI withou success. The kernel
2.5.{29,30} don't even compile (error with: save_flags
and restore_flags, listed below).

I'm using red hat 2.4.18-3 recompiled right now, that
looks too old (I tried 2.5.24 before, the /proc/acpi
subsys gives more info)

I got acpid, but I got nothing more than mapping the
buttons (power and lid) to run what I desire. I wanna
know how I put it to sleep (suspend, and how to come
back)

Best regards.

Gustavo

--------------
make bzImage errors:

drivers/built-in.o: In function `acpi_system_suspend':
drivers/built-in.o(.text+0x3220e): undefined reference
to `save_flags'
drivers/built-in.o(.text+0x3223b): undefined reference
to `restore_flags'


_______________________________________________________________________
Yahoo! PageBuilder
O super editor para criação de sites: é grátis, fácil e rápido.
http://br.geocities.yahoo.com/v/pb.html


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
