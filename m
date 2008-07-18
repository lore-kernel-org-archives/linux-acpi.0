From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 02/11] Check for ACPI backlight support otherwise use vendor ACPI drivers
Date: Fri, 18 Jul 2008 04:54:42 +0200
Message-ID: <200807180454.43347.trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <200807171552.12974.trenn@suse.de> <1216351113.26321.35.camel@segulix.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:42262 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbYGRD2V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 23:28:21 -0400
In-Reply-To: <1216351113.26321.35.camel@segulix.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Friday 18 July 2008 05:18:32 am Sergio Monteiro Basto wrote:
> On Thu, 2008-07-17 at 15:52 +0200, Thomas Renninger wrote:
> > I just had a quick look on each, do not give much on above statements.
> > If there is any outcome on 9642 (_DOS=1 works, _DOS=0 fails on HPs and
> > LID),
> > pls let me know.
>
> 9642 , is about my laptop, I will happily try yours patches , and report
> back
Wait..., these patches are unrelated to this one.
I meant: if you come further and find out something, pls tell me.
(Theoretically we could blacklist them easily to not use display output 
switching with the patch, but better still try a bit).
I know about a lot HP and others having problems with _DOS=0 and freezing on 
LID:
https://bugzilla.novell.com/show_bug.cgi?id=378917 (-> a lot duplicates)
https://bugzilla.novell.com/show_bug.cgi?id=290219

        Thomas
