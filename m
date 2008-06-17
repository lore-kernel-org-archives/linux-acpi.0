From: Greg KH <greg@kroah.com>
Subject: Re: Toshiba - Documentation for Linux Developers
Date: Tue, 17 Jun 2008 16:44:37 -0700
Message-ID: <20080617234437.GA32316@kroah.com>
References: <4855971D.90004@diamondcut.com.br> <20080616221443.GA760@kroah.com> <485799B6.2010302@diamondcut.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:37479 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893AbYFQXuZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 19:50:25 -0400
Content-Disposition: inline
In-Reply-To: <485799B6.2010302@diamondcut.com.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Renato S. Yamane" <yamane@diamondcut.com.br>
Cc: linux-acpi@vger.kernel.org

On Tue, Jun 17, 2008 at 08:02:14AM -0300, Renato S. Yamane wrote:
> Greg KH wrote:
> > Renato S. Yamane wrote:
> >> Toshiba have a 'link' between Linux Developers and Head Company, that is:
> >> <http://linux.toshiba-dme.co.jp/linux/eng/develop.htm>
> >>
> >> If someone need documentation to develop Linux drivers, contact
> >> linux@toshiba-dme.co.jp
> > 
> > Are there any known drivers for Toshiba hardware that you need for Linux
> > that we should be contacting them about?
> 
> Greg, in my Toshiba M45-S355, multimedia keys (play, pause, stop, etc)
> and Fn+Fx keys don't work.
> 
> With no Fn keys, I can't change brightness of monitor (Fn+F6/F7) and
> change output video from LCD to VGA (Fn+F5).
> 
> I try use "xev" to capture key press, but Fn and Multimedia Keys is not
> recognized.
> 
> And other problem is with battery charge, as we can see here:
> <http://bugzilla.kernel.org/show_bug.cgi?id=10797>

Have you discussed this with the maintainers that Len pointed out?

thanks,

greg k-h
