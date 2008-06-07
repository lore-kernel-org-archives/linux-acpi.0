From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: bug? acpi p-state + ondemand keeps dropping max freq
Date: Sat, 7 Jun 2008 14:54:35 -0700
Message-ID: <20080607145435.4afc9812@infradead.org>
References: <20080606140846.GA9580@ucw.cz>
	<20080607213918.GC1746@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:52801 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbYFGWNX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jun 2008 18:13:23 -0400
In-Reply-To: <20080607213918.GC1746@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: pavel@suse.cz, auke-jan.h.kok@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, cpufreq@lists.linux.org.uk, davej@codemonkey.org.uk

On Sat, 7 Jun 2008 23:39:18 +0200
Pavel Machek <pavel@suse.cz> wrote:

> > # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> > 800000
> > # echo 1866000 > scaling_max_freq ; cat scaling_max_freq
> > 800000
> > 
> > 
> > This renders my Dothan to utterly poor speeds. (standard T43)
> > 
> > performance cpufreq governor makes no difference - I still can't
> > change the frequency upper/lower values.
> 
> Hmm, I have similar problem in Novell bugzilla, on very different hw:
> 
> https://bugzilla.novell.com/show_bug.cgi?id=396311
> 
> 								Pavel
> 


are either of you running gnome-power-manager or kpowersaved ?
sometimes these programs (and more likely, the patches added by a
distro maintainer who doesn't fully realize how power works) tend to
muck with kernel settings around CPU frequency that they have
absolutely no business touching...


-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
