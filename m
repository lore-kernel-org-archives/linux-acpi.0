From: Len Brown <lenb@kernel.org>
Subject: Re: bug? acpi p-state + ondemand keeps dropping max freq
Date: Tue, 17 Jun 2008 14:15:38 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806171404370.7277@localhost.localdomain>
References: <20080606140846.GA9580@ucw.cz> <20080607213918.GC1746@elf.ucw.cz>
 <20080607145435.4afc9812@infradead.org> <20080616104159.GA28659@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:34834 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbYFQSQH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 14:16:07 -0400
In-reply-to: <20080616104159.GA28659@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, auke-jan.h.kok@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, cpufreq@lists.linux.org.uk, davej@codemonkey.org.uk



> > > > # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> > > > 800000
> > > > # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> > > > 800000
> > > > 
> > > > 
> > > > This renders my Dothan to utterly poor speeds. (standard T43)
> > > > 
> > > > performance cpufreq governor makes no difference - I still can't
> > > > change the frequency upper/lower values.
> > > 
> > > Hmm, I have similar problem in Novell bugzilla, on very different hw:
> > > 
> > > https://bugzilla.novell.com/show_bug.cgi?id=396311
> 
> > are either of you running gnome-power-manager or kpowersaved ?
> > sometimes these programs (and more likely, the patches added by a
> > distro maintainer who doesn't fully realize how power works) tend to
> > muck with kernel settings around CPU frequency that they have
> > absolutely no business touching...
> 
> In novel bugzilla case ignore_ppc=1 helped, so it seems to be BIOS
> problem, not userland's...

Thanks for the pointer to the novell report, Pavel.
I poked at that one and I think it may actually be a table loading issue
for which we've just send a patch to 2.6.26.

Auke,

Please open a signting in bugzilla and attach your dmesg and 
acpidump output.

Also, please report if processor.ignore_ppc=1 helps.

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

thanks,
-Len

