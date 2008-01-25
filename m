From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 8/8] ACPI: DMI blacklist to reduce console warnings on OSI(Linux) systems.
Date: Fri, 25 Jan 2008 15:36:58 -0500
Message-ID: <200801251536.58439.lenb@kernel.org>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org> <200801232335.03453.lenb@kernel.org> <200801240454.42732.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41106 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbYAZCro (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2008 21:47:44 -0500
In-Reply-To: <200801240454.42732.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

On Wednesday 23 January 2008 23:54, you wrote:
> On Thursday 24 January 2008 04:35:03 Len Brown wrote:
> > I'm surprised to discover it uses strstr() and matches
> > substrings instead.  Is there logic behind that?
> 
> As for the exact reason, no idea - you'd have to ask whoever is responsible 
> for that. It's just a curious thing I've noticed and has come in rather 
> handy.
> 
> As a side effect though, it does avoid lots of nasty unpleasantness with 
> vendor whitespace padding abuse.
> 
> Otherwise, as Acer in particular love to pad many of their DMI entries with 
> whitespace, we'd be scratching our heads forever as to why an entry doesn't 
> work if we slip up and miss a whitespace character or two.
> 
> So at least from my perspective, substring matching is a good thing.

Yes, I've seen DMI entries with trailing whitespace too -- very irritating.

I considered putting quotes around the recent DMI console messages,
but decided against it since we'd more likely get the real dmesg
and copy paste, rather than copying stuff off a screen where whitespace is lost.

I'll delete the longer of the Acer matches int this case,
as it would result in us printing two console messages.

thanks for pointing this out,
-Len
