From: dienet <dienet@poczta.fm>
Subject: Resuming from hibernation on T61 with nvidia
Date: Tue, 15 Nov 2011 20:02:31 +0100
Message-ID: <op.v4z4ihs2wcw97g@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:46647 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138Ab1KOTVK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2011 14:21:10 -0500
Received: from localhost (77-253-250-133.adsl.inetia.pl [77.253.250.133])	(using TLSv1
	with cipher DHE-RSA-AES256-SHA (256/256 bits))	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA
	for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2011 20:02:12 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello

As far I can remember (since I have my ThinkPad T61), there is problem  
with resuming from hibernation (suspend-to-disk) on this system. And I  
know that there are lots of people with the same problem.
I was checking lots of kernel versions but with no luck.

Was is the problem? In my T61 I have 01:00.0 VGA compatible controller:  
nVidia Corporation G84M [Quadro NVS 140M] (rev a1) and I am using nvidia  
drivers (also checked quite a few versions without any luck). Suspending  
to disk is working without any problem. The problem is when I want to  
resume. The resume process is stopping at some point (I think after the  
pages are red) for about 60 seconds. After that time, the resume process  
is continuing, and after few sec, I am back in X11.

I have motivation to fix it, but:

1. How to trace it?
2. Is it possible to fix this? Maybe the fix should take place in nvidia  
driver (nvidia.o), and that can not be done. But maybe the fix can be done  
in kernel?

I want to notice that, if the fix will only work for me, then that is fine  
with me.

I know that answer to 2. might be hard, so maybe some guide how to trace  
the problem?

-- 
pozdr0
dienet

"Old C programmers never die. They're just cast into void."

----------------------------------------------------------------
Nie zmieniaj opon, zmien auto!
http://linkint.pl/f2a7c
