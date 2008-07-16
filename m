From: Thomas Renninger <trenn@suse.de>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPI drivers - version 2
Date: Wed, 16 Jul 2008 13:16:26 +0200
Message-ID: <200807161316.29723.trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <20080716105931.GC1701@corsac.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:50090 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbYGPLQc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 07:16:32 -0400
In-Reply-To: <20080716105931.GC1701@corsac.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Thomas Renninger <trenn@suse.de>Thomas Renninger <trenn@suse.de>

Hi Yves,

I hope it's ok for that I add the people to CC again.
Others might have the same question(s).

On Wednesday 16 July 2008 12:59:31 Yves-Alexis Perez wrote:
> On Wed, Jul 16, 2008 at 12:52:22PM +0200, Thomas Renninger wrote:
> > It is highly recommended that these patches are tried out together with
> > Matthew's/Hong's IGD driver changes.
> > I do not know whether they are already in the dri tree or in linux-next,
> > whether they will be accepted for .27 etc. I hope Matthew will answer on
> > this mail and tell us.
> > AFAIK on thinkpads they already need an additional patch to work?
> > Chances are high that other laptop families also need a bit of a special
> > treatment to get the very new IGD parts to work.
> > If people test both patches together we could get a matrix like this:
>
> Hmmh, running on a Thinkpad T61 with intel
There are T61 with Intel and with Nvidia graphics cards.
The first may have (on all recent ThinkPad BIOS they should all have) an IGD 
interface provided by BIOS.
These are the generic ACPI functions plus a bit more on top.

> and a vista-capable bios, 
Since Vista all laptops seem to have the generic ACPI backlight functions 
added. Goal is to use them whenever possible instead of vendor specific ones.

> what does this mean? Which patches do I need, and against which tree?
Matthew has to tell us. I have no idea.

> I guess I at least need to apply those 11 patches against acpi tree,
Yes. Andi's acpi release branch.
It is enough to take the first 2 generic and your laptop model specific one(s) 
if you are lazy.
> but  
> what are the "Matthew's/Hong's IGD driver changes" and the "additional
> patch to work"?
I saw Matthew posting on the dri list. But he said about problems with 750 ms 
delays which he could solve.
Therefore I do not want to point people to wrong patches.
All I know is that Matthew got things working as they should work.

Thanks for the feedback!

       Thomas

