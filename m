From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: [PATCH][2.4] acpi S5 poweroff fix
Date: Wed, 30 Apr 2003 09:09:19 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <03ea01c30f11$53ec94a0$3746028e@bio.dfo.ca>
References: <20030429181518.96485.qmail@web41601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;	charset="Windows-1252"
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
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: "willy tarreau" <wtarreau-Qt13gs6zZMY@public.gmane.org>

> Although I'm not sure that the second case affects everybody, because it might
> be caused by side-effects, but from what I've understood from the code, I'm
> pretty sure that nobody can power off by echoing 5 to /proc/acpi/sleep !

Mostly we wouldn't want to.  iirc, there was some discussion here about not even
permitting "echo 5 >/proc/acpi/sleep".  If I am forced to recover from the (too
frequent) situation where my laptop freezes and ignores the keyboard, I have to
hold down the power button for 4 or 5 seconds, as you mention.  But that, like
S5, is an abrupt power-off.  Generally, I'd want to go through init and do it
gracefully.  Pushing the power button once is enough to generate a power button
event in acpi, and then acpid shuts the machine down using '/sbin/init 0'



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
