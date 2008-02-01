From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Fri, 01 Feb 2008 10:53:57 +0100
Message-ID: <1201859637.14573.41.camel@queen.suse.de>
References: <4798E2A5.6020804@users.sf.net>
	 <1201714051.1222.131.camel@queen.suse.de>
	 <47A0FBD4.6090603@tremplin-utc.net>  <200801311417.57469.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:33743 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759090AbYBAJx7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Feb 2008 04:53:59 -0500
In-Reply-To: <200801311417.57469.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: =?ISO-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

On Thu, 2008-01-31 at 14:17 -0500, Len Brown wrote:
> > > In fact, I added the array some time ago.
> > > Not sure whether the latest Version of Eric/Markus can also load several
> > > DSDT/SSDTs? Maybe you found a more elegant way?
> 
> > Nope. On the website (http://gaugusch.at/kernel.shtml) you can just find 
> > two versions of the patch: one simple and one with your addition for 
> > SSDTs support. At least with SSDTs support there is even an advantage 
> > over the DSDT-in-kernel version :-)
> 
> 
> At one point there was a proposal to allow in-kernel SSDT overrides,
> but we determined that it was problematic because there can be any
> number of SSDTs (so which one does an override apply to?),
> some of them auto loaded at RSDT time, and the others
> loaded at run-time via Load() in the DSDT (and possibly SSDT) AML.
Yes and this is easy to solve via initrd.

> So we decided that to override an SSDT, you  need to override a DSDT,
> incorporate whatever SSDT code you want into your DSDT, and boot with the
> "acpi_no_auto_ssdt" cmdline parameter to inhibit autoloading
> of the RSDT enumerated SSDTs.  That gives you complete and total
> control over what AML gets run.  (you omit that cmdline param
> to overide the DSDT but keep the native SSDTs)  It also gives you
> just 1 DSDT to keep track of.
I know and it's a rather complex way.
You need to open the DSDT and copy and paste in an editor all SSDTs into
DSDT (inside the last bracket, the global namespace, so simply attaching
it at the very end is not working). Is that correct?
> That gives you complete and total control over what AML gets run
I doubt that. You said there can be any number of SSDTs. If you know
what you are doing..., but how do you explain someone in a bug that he
has to collect all SSDTs (some via acpidump --addr xy) open an editor,
paste them into the DSDT and so on...
I know what you mean and in what pits you could fall, because I've tried
it already, but...

> I'm not clear on how to use the proposed initrd SSDT override capability,
> and why it needs to be different from the simple scheme above,
... it is far away from a simple scheme, sorry.

> but I wouldn't want a mess there to hold up the rest of the initrd
> DSDT override patch series -- since only very rarely is an SSDT
> override needed.
That's true, it's not needed that often and the patch shouldn't be hold
off because of that.

Let me explain again what the intend is:
You pass to initrd e.g.:
/
/DSDT.aml /SSDT1.aml /SSDT2.aml

(maybe it should be done in an own dsdt directory. Like that, one could
check for each file in this directory, instead of the static array files
that get checked, hmmm this possibly should decided now to avoid
incompatibilities).
Anyway, say you have a directory:
/dsdt
with two SSDTs sitting there that get loaded before any other table gets
loaded.
Those tables have been extracted with acpidump, disassembled with iasl
-d, modified (e.g. added some debug code to get printed to syslog) and
recompiled.
Those tables have the same OEM id then the original ones, right?
Tables with the same OEM id (the original ones) should get ignored later
automatically. IIRC I had some problems with dynamically loaded tables,
don't know anymore, they are not that often used and theoretically it
should just work for them also.
I haven't tried too much here, but SSDTs are used more and more often (I
saw a machine with 12 SSDTs, especially on IA64 there might be dozens in
the future). We should think about the problem now, before we have bugs
and need to write down half a book how the reporter finally could
provide some useful information.

Have I overseen something?

    Thomas

