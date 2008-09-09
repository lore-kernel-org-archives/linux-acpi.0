From: Pavel Machek <pavel@suse.cz>
Subject: Re: [regression] Re: Controlling backlight on thinkpad x60
Date: Tue, 9 Sep 2008 17:36:54 +0200
Message-ID: <20080909153654.GA2731@elf.ucw.cz>
References: <20080908151058.GA1650@elf.ucw.cz> <20080908155457.GA30619@srcf.ucam.org> <20080909152859.GA1813@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45384 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927AbYIIQhx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2008 12:37:53 -0400
Content-Disposition: inline
In-Reply-To: <20080909152859.GA1813@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue 2008-09-09 17:28:59, Pavel Machek wrote:
> On Mon 2008-09-08 16:54:58, Matthew Garrett wrote:
> > On Mon, Sep 08, 2008 at 05:10:58PM +0200, Pavel Machek wrote:
> > 
> > > (I do have CONFIG_ACPI_VIDEO disabled, it killed my machine last time
> > > I enabled it, is it mandatory now?)
> > 
> > On Thinkpads with ACPI video support, yes.
> 
> That's bad then, because ACPI video support does not work here. I can
> boot, and even Fn-home/end works, but it breaks with X.
> 
> In old versions, it resulted on black screen after LID close in X.
> 
> In 2.6.27-rc5, screen goes black as soon as X are started.

Hmm, I have updated my X server, and it now works with
ACPI_VIDEO... which means that this is probably not affecting huge
number of people.

Hmm... something is still funny. I have 

root@amd:/sys/class/backlight/acpi_video0# echo 1 > brightness
root@amd:/sys/class/backlight/acpi_video0# echo 0 > brightness
root@amd:/sys/class/backlight/acpi_video0# cd ../acpi_video1/
root@amd:/sys/class/backlight/acpi_video1# echo 0 > brightness
root@amd:/sys/class/backlight/acpi_video1# echo 7 > brightness
root@amd:/sys/class/backlight/acpi_video1# echo 0 > brightness


...and both acpi_video0 *and* acpi_video1 works... strange.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
