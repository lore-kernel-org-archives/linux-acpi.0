From: Sven Geggus <lists@fuchsschwanzdomain.de>
Subject: Enforcing C2,C3... states?
Date: Thu, 20 Dec 2007 19:08:43 +0100
Message-ID: <20071220180843.GA5634@diesel.geggus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dolly.gnuher.de ([212.227.64.154]:51032 "EHLO dolly.gnuher.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756578AbXLTSxc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Dec 2007 13:53:32 -0500
Received: from ultimate100.geggus.net ([2001:8d8:81:672::1])
	by dolly.gnuher.de with esmtpsa TLS-1.0:RSA_AES_256_CBC_SHA:32
	(Exim 4.66 id 1J5Pp6-0002xz-V8)
	for <linux-acpi@vger.kernel.org>; Thu, 20 Dec 2007 19:08:45 +0100
Received: from diesel.geggus.net ([192.168.3.2] ident=mail)
	by ultimate100.geggus.net with esmtp
	(Exim 4.66 id 1J5Pp6-0004SD-4r)
	for <linux-acpi@vger.kernel.org>; Thu, 20 Dec 2007 19:08:44 +0100
Received: from sven by diesel.geggus.net with local
	(Exim 3.36 id 1J5Pp6-0001TK-00)
	for <linux-acpi@vger.kernel.org>; Thu, 20 Dec 2007 19:08:44 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear ACPI List,

Desktop Boards usually don't seem to activate power management as
one can see in /proc/acpi/processor/CPU?/power even if they use a
Laptop CPU which would be able to use this states.

Would it be possible to enforce the Use of C2,C3... Power states on
those kind of machines by means of a modified dsdt?

if so, what would I need to add to the ACPI Bios to achieve this?

Regards

Sven

-- 
"Those who do not understand Unix are condemned to reinvent it, poorly"
(Henry Spencer)

/me is giggls@ircnet, http://sven.gegg.us/ on the Web
