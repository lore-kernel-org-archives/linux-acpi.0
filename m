From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 02/11] Check for ACPI backlight support otherwise use vendor ACPI drivers
Date: Thu, 17 Jul 2008 15:52:10 +0200
Message-ID: <200807171552.12974.trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <20080716111611.GA27442@srcf.ucam.org> <1216213287.5678.17.camel@segulix.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54477 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756566AbYGQNwS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 09:52:18 -0400
In-Reply-To: <1216213287.5678.17.camel@segulix.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Wednesday 16 July 2008 15:01:27 Sergio Monteiro Basto wrote:
> Hi, this patches are the a solution on i915 with backlight problems and
> others ?
>
> like
>
> https://bugzilla.redhat.com/show_bug.cgi?id=351661
Here you probably need the IGD parts also.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=389541
Some machines need a switch to console 1 and back to X.
Don't ask me what is missing and what X could do here 
automatically. We have a workaround to just switch the
displays after suspend (not sure whether it's on by default)
but it's a config variable.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=201472
No idea, nothing with backlight, X problem?
>
> https://bugzilla.redhat.com/show_bug.cgi?id=423931
It's a Dell..., is the dcdbas driver involved?
See discussion on my previous posts with Matthew and
the Dell hal bug. Could be related..
>
> https://bugs.freedesktop.org/show_bug.cgi?id=13709
Sounds worth a test.
>
> https://bugs.freedesktop.org/show_bug.cgi?id=12852
This also could be related.

> http://bugzilla.kernel.org/show_bug.cgi?id=10985
unrelated.
>
> http://bugzilla.kernel.org/show_bug.cgi?id=9642
No idea. I have a bug where a lot HP people reported a freeze
when using the LID. They should be lucky that only backlight
is dark :).
Oh wait, _DOS=1 works, _DOS=0 fails -> probably the same
issue. This one is nasty and very critical (a lot HPs freeze), but I did
not have time to look at anything.
>
> http://bugzilla.kernel.org/show_bug.cgi?id=9827
Defintely worth a test with IGD enhancements.


I just had a quick look on each, do not give much on above statements.
If there is any outcome on 9642 (_DOS=1 works, _DOS=0 fails on HPs and LID), 
pls let me know.

        Thomas
