From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/6] sony-laptop fixes for 2.6.30-rc2
Date: Sat, 18 Apr 2009 01:16:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904180115500.30751@localhost.localdomain>
References: <1239535591-15514-1-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:44053 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbZDRFQa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Apr 2009 01:16:30 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIA00EDU6NDCZLG@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 18 Apr 2009 00:16:26 -0500 (CDT)
In-reply-to: <1239535591-15514-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

On Sun, 12 Apr 2009, Mattia Dongili wrote:

> Hi Len,
> 
> a few fixes for the new code handling the SNC devices, a fix for a small bug in
> the resume path and a patch for ec.c that allows sony-laptop to restore the
> brightness level on resume.
> 
> Almer S. Tigelaar (4):
>   sony-laptop: Duplicate SNC 127 Event Fix
>   sony-laptop: SNC 127 Initialization Fix
>   sony-laptop: SNC input event 38 fix
>   ec.c: Fix ACPI EC resume non-query interrupt message
> 
> Mattia Dongili (2):
>   sony-laptop: fix bogus error message display on resume
>   sony-laptop: always try to unblock rfkill on load
> 
>  drivers/acpi/ec.c                  |    1 +
>  drivers/platform/x86/sony-laptop.c |   27 ++++++++++++++++++++-------
>  2 files changed, 21 insertions(+), 7 deletions(-)

applied to acpi-test



thanks,
Len Brown, Intel Open Source Technology Center
