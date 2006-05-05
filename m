From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: fixed samsung r65 dsdt
Date: Fri, 5 May 2006 17:19:26 +0200
Message-ID: <20060505151926.GA5839@poupinou.org>
References: <3f6a1ade0605050345m4837d5a7g22ff30ab513eae1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:8753 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id S1751446AbWEEPT3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2006 11:19:29 -0400
Content-Disposition: inline
In-Reply-To: <3f6a1ade0605050345m4837d5a7g22ff30ab513eae1c@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Kombrink <katakombi@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Fri, May 05, 2006 at 12:45:06PM +0200, Stefan Kombrink wrote:
> Hi there,
> 
> I've got a Samsung R65 Charis several days ago, and noticed that the
> DSDT is not found by the kernel.
> After fixing it (11 Errors, 1 Warning still left) the frequency
> scaling seems to work (1.0/1.3/1.6GHz)
> Since most probably I am going to return the notebook, I cannot do
> further testings (means suspend/hibernate).
> (I think the NVidia card might cause the trouble as well)
> However, compile the .hex into your kernel, and speed step should work :)
> 

I don't see any acpi methods for p-states on that ASL.  I guess
therefore it's not into the DSDT but instead into a SSDT.


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
