From: Pavel Machek <pavel@suse.cz>
Subject: [regression] Re: Controlling backlight on thinkpad x60
Date: Tue, 9 Sep 2008 17:29:00 +0200
Message-ID: <20080909152859.GA1813@elf.ucw.cz>
References: <20080908151058.GA1650@elf.ucw.cz> <20080908155457.GA30619@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45385 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032AbYIIQhy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2008 12:37:54 -0400
Content-Disposition: inline
In-Reply-To: <20080908155457.GA30619@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon 2008-09-08 16:54:58, Matthew Garrett wrote:
> On Mon, Sep 08, 2008 at 05:10:58PM +0200, Pavel Machek wrote:
> 
> > (I do have CONFIG_ACPI_VIDEO disabled, it killed my machine last time
> > I enabled it, is it mandatory now?)
> 
> On Thinkpads with ACPI video support, yes.

That's bad then, because ACPI video support does not work here. I can
boot, and even Fn-home/end works, but it breaks with X.

In old versions, it resulted on black screen after LID close in X.

In 2.6.27-rc5, screen goes black as soon as X are started.

(In old versions, I could use ibm-acpi, and fn-home/end worked even
without CONFIG_ACPI_VIDEO...)

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
