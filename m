From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.20-rc6-mm3
Date: Sat, 3 Feb 2007 01:37:52 +0100
Message-ID: <20070203003752.GC1712@elf.ucw.cz>
References: <20070129204528.eb8d695e.akpm@osdl.org> <200701310155.05474.fzu@wemgehoertderstaat.de> <20070131132245.GA26066@elte.hu> <200701311525.50160.fzu@wemgehoertderstaat.de> <20070201080108.GC14378@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46706 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1946446AbXBCLHQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Feb 2007 06:07:16 -0500
Content-Disposition: inline
In-Reply-To: <20070201080108.GC14378@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <fzu@wemgehoertderstaat.de>, Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi!

> * Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:
> 
> > Serial port console is off here and the jiffies update fix doesn't 
> > make a noticeable difference.
> 
> ok, this eliminates my serial port theory.
> 
> and this means i'm having trouble reproducing this problem locally. 
> Maybe i tried it the wrong way: does it only occur with suspend-to-disk, 
> or suspend-to-ram too? Does it need ACPI suspend-to-disk, or 
> software-suspend?

? What is ACPI suspend-to-disk? There used to be S4bios *long* time
ago... these days everyone does swsusp.

(Granted, you can select "shutdown" and "platform" flavours...)
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
