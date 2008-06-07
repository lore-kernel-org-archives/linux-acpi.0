From: Michel Lespinasse <walken@zoy.org>
Subject: PTS ordering / asus P1-AH2 system
Date: Fri, 6 Jun 2008 21:06:50 -0700
Message-ID: <20080607040650.GA21015@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.lespinasse.org ([64.142.28.226]:53391 "EHLO
	server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbYFGE3x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jun 2008 00:29:53 -0400
Received: from michel.lespinasse.org (michel.home.lespinasse.org [10.1.0.1])
	by server.lespinasse.org (Postfix) with ESMTP id 77A672FC5D
	for <linux-acpi@vger.kernel.org>; Fri,  6 Jun 2008 21:06:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

Hi,

I am wondering, are there patches for 2.6.25.* or 2.6.26-rc* to
work around the suspend/resume PTS ordering issue, even using
a kernel parameter if needed ?

My asus P1-AH2 system won't suspend without this so I'm currently
stuck at 2.6.21.7....

Thanks,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
