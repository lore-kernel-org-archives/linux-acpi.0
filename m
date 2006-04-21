From: Volker Braun <volker.braun@physik.hu-berlin.de>
Subject: RE: how to back from suspend without shutdown
Date: Fri, 21 Apr 2006 10:27:48 -0400
Message-ID: <pan.2006.04.21.14.27.47.446178@physik.hu-berlin.de>
References: <554C5F4C5BA7384EB2B412FD46A3BAD13783F5@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:21725 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932334AbWDUO2t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 10:28:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FWwcd-0008Ve-A5
	for linux-acpi@vger.kernel.org; Fri, 21 Apr 2006 16:28:35 +0200
Received: from carrot.hep.upenn.edu ([128.91.45.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 21 Apr 2006 16:28:35 +0200
Received: from volker.braun by carrot.hep.upenn.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 21 Apr 2006 16:28:35 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I ran into that problem, too. Since the acpid stop/resume workaround
is so obvious I didn't make a lot of noise about it. But it would be good
if it worked automatically.

Volker

On Fri, 21 Apr 2006 09:43:42 +0800, Yu, Luming wrote:
> Hmm,  it is an easy and ugly workaround. I bet this kind of question
> would be raised again and again on this mailing list, if no code fix
> exists.



