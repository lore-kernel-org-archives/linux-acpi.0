From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Fwd: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Wed, 30 Jan 2008 11:16:44 +0100
Message-ID: <200801301116.44902.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_M6EoHbwur9yOyNu"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44769 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbYA3KS7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jan 2008 05:18:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Kevin Hilman <khilman@mvista.com>

--Boundary-00=_M6EoHbwur9yOyNu
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Please have a look at this.

Rafael

--Boundary-00=_M6EoHbwur9yOyNu
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: Kevin Hilman <khilman@mvista.com>: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Content-Disposition: inline

Return-Path: <linux-pm-bounces@lists.linux-foundation.org>
Received: from murder ([unix socket])
	 by ogre.sisk.pl (Cyrus v2.2.12) with LMTPA;
	 Wed, 30 Jan 2008 06:31:08 +0100
X-Sieve: CMU Sieve 2.2
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id D77468A143
	for <rafael@ogre.sisk.pl>; Wed, 30 Jan 2008 06:31:08 +0100 (CET)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07841-10 for <rafael@ogre.sisk.pl>; Wed, 30 Jan 2008 06:30:50 +0100 (CET)
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org [207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 8B9F78A13A
	for <rjw@sisk.pl>; Wed, 30 Jan 2008 06:30:50 +0100 (CET)
Received: from murdock.linux-foundation.org (localhost [127.0.0.1])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0U5qMar002162;
	Tue, 29 Jan 2008 21:52:43 -0800
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by smtp2.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	m0U5qI8D002156 for <linux-pm@lists.linux-foundation.org>;
	Tue, 29 Jan 2008 21:52:19 -0800
Received: from paris.hilman.org (asshur.mvista.com [10.0.0.11])
	by hermes.mvista.com (Postfix) with ESMTP id 6B302181F8
	for <linux-pm@lists.linux-foundation.org>;
	Tue, 29 Jan 2008 21:52:12 -0800 (PST)
To: linux-pm@lists.linux-foundation.org
From: Kevin Hilman <khilman@mvista.com>
Organization: MontaVista Software, Inc.
Date: Tue, 29 Jan 2008 21:52:12 -0800
Message-ID: <871w7zn9mb.fsf@paris.hilman.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain;
  charset=us-ascii
Received-SPF: pass (localhost is always allowed.)
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.22
Subject: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
X-BeenThere: linux-pm@lists.linux-foundation.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Linux power management <linux-pm.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
X-Length: 3630
X-UID: 538968

Wrap cpu_idle_wait() in an x86 #ifdef since it's x86 only.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d2fabe7..4d0f9b0 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -82,7 +82,9 @@ void cpuidle_uninstall_idle_handler(void)
 {
 	if (enabled_devices && (pm_idle != pm_idle_old)) {
 		pm_idle = pm_idle_old;
+#ifdef CONFIG_X86
 		cpu_idle_wait();
+#endif
 	}
 }

_______________________________________________
linux-pm mailing list
linux-pm@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/linux-pm


--Boundary-00=_M6EoHbwur9yOyNu--
