From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Fwd: Stability fixes only, _please_]
Date: 09 Oct 2003 14:42:50 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1065724970.2507.60.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-tMPTiMLMjrEDy3vAPxRu"
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


--=-tMPTiMLMjrEDy3vAPxRu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In the event you haven't see Linus's request to include bug-fixes only
in 2.6.0 from here on out.

I think that:
1. if bugzilla entries are associated with each patch,
   that will help make the case.
2. I should probably to create a linux-acpi-test-2.6.1 tree now
   to hold stuff that will need to wait for that release to open.

thanks,
-Len


--=-tMPTiMLMjrEDy3vAPxRu
Content-Disposition: inline
Content-Description: Forwarded message - Stability fixes only, _please_
Content-Type: message/rfc822

Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by
	hdsmsx402.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Wed, 8
	Oct 2003 16:15:41 -0400
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by
	hdsmsx401.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Wed, 8
	Oct 2003 16:15:41 -0400
Received: from scsmsx402.amr.corp.intel.com ([10.3.90.16]) by
	fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Wed, 8
	Oct 2003 13:15:32 -0700
Received: from scsmsx332.amr.corp.intel.com ([10.3.90.6]) by
	scsmsx402.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Wed, 8
	Oct 2003 13:15:32 -0700
Received: from scsmsxvs041.sc.intel.com ([10.3.90.10]) by
	scsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Wed, 8
	Oct 2003 13:15:32 -0700
Received: from petasus.sc.intel.com ([10.3.253.4]) by
	scsmsxvs041.sc.intel.com (NAVGW 2.5.2.11) with SMTP id M2003100813153003887
	for <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Wed, 08 Oct 2003 13:15:30 -0700
Received: from caduceus.sc.intel.com (caduceus.sc.intel.com [10.3.252.4])
	by petasus.sc.intel.com (8.11.6-20030918-01/8.11.6/d: inner.mc,v 1.35
	2003/05/22 21:18:01 rfjohns1 Exp $) with ESMTP id h98KDoJ18659 for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Wed, 8 Oct 2003 20:13:50 GMT
Received: from mail.osdl.org (fw.osdl.org [65.172.181.6]) by
	caduceus.sc.intel.com (8.12.9-20030918-01/8.12.9/d: outer.mc,v 1.66
	2003/05/22 21:17:36 rfjohns1 Exp $) with ESMTP id h98KFn93026556 for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Wed, 8 Oct 2003 20:15:50 GMT
Received: from localhost (build.pdx.osdl.net [172.20.1.2]) by mail.osdl.org
	(8.11.6/8.11.6) with ESMTP id h98KDg119975; Wed, 8 Oct 2003 13:13:43 -0700
Date: Wed, 8 Oct 2003 13:13:40 -0700 (PDT)
From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
To: David Miller <davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Randy Dunlap <rddunlap@osdl.org>, Andrea Arcangeli <andrea@suse.de>, Arnaldo Carvalho de Melo <acme@conectiva.com.br>, Dave Jones <davej@redhat.com>, Dave Kleikamp <shaggy@austin.ibm.com>, David Mosberger <davidm@napali.hpl.hp.com>, Greg KH <greg@kroah.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <James.Bottomley@SteelEye.com>, Jaroslav Kysela <perex@suse.cz>, Jeff Garzik <jgarzik@pobox.com>, Len Brown <len.brown@intel.com>, Nick Piggin <piggin@cyberone.com.au>, Patrick Mochel <mochel@osdl.org>, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>, Steve Lord <lord@sgi.com>, Stephen Hemminger <shemminger@osdl.org>, Trond Myklebust <trond.myklebust@fys.uio.no>, Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
cc: Architectures Group <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Stability fixes only, _please_
Message-ID: <Pine.LNX.4.44.0310081250390.2031-100000-Xqd2YWsQM6mXDw4h08c5KA@public.gmane.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.31 (www . roaringpenguin . com / mimedefang)
Return-Path: torvalds-3NddpPZAyC0@public.gmane.org
X-OriginalArrivalTime: 08 Oct 2003 20:15:32.0464 (UTC)
	FILETIME=[ECF81700:01C38DD8]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


[ The recipient list is a list of people who I have merged with through BK
  fairly recently or are otherwise active (or are just a result of random
  grepping on my mailbox and/or the changelog). The BK side is
  particularly important, since unlike patches, with BK I can't just
  select the parts I want. ]

I just released 2.6.0-test7, and I'm _really_ hoping to calm down
development by the end of October. The test-releases have been about two
weeks apart, and they've been about half a megabyte of patches PER WEEK.  
Thst just isn't conductive to stabilization, because even if most of the
patches end up being fairly simple, it means that there are a LOT of
simple patches, and inevitably some of them have unintentional side 
effects (*).

In the 2.6.0-test7 release notes for the kernel mailing list, I said:

   The more interesting thing is that I and Andrew are trying to calm down 
   development, and I do _not_ want to see patches that don't fix a real and 
   clear bug. In other words, the "cleanup and janitorial" stuff is on hold, 
   and -test8 and then -test9 should be for _stability_ fixes only.

   In other words, this should calm things down so that by the end of October
   we can look at the state of 2.6.0 without having a lot of noise from "not
   strictly necessary" stuff.

and I _really_ need your help for this to work. In particular, it means
that you shouldn't point me to BK trees that may have a real bug fix, but
also have other noncritical stuff in them. 

And you should _not_ spend any time at all doing cleanups. Zero. If you
work for a Linux company, and your manager asks you to do cleanups, please
put some poison in his morning cereal. Or something (if you like your
manager - hah - just tell him why you shouldn't do cleanups).

And if you see a bug, and there is an ugly but _immediate_ fix for it, do
the ugly and immediate thing instead of trying to clean it up. Add a
"FIXME!" comment if that makes your conscience feel better, but don't
bother trying to do the clean thing that touches something else too.

Please.

Spread the word to "your guys" too, ok?

		Linus

(*) Euphemism of the day. They are buggy, or even if "perfect" they may
trigger a bug somewhere else. And even if they are perfect works of art, 
they distract us from what should matter now: the pure stability work.


--=-tMPTiMLMjrEDy3vAPxRu--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
