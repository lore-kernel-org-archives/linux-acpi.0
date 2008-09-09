From: Pavel Machek <pavel@suse.cz>
Subject: Re: [regression] Re: Controlling backlight on thinkpad x60
Date: Tue, 9 Sep 2008 18:55:58 +0200
Message-ID: <20080909165558.GB1691@elf.ucw.cz>
References: <20080908151058.GA1650@elf.ucw.cz> <20080908155457.GA30619@srcf.ucam.org> <20080909152859.GA1813@elf.ucw.cz> <20080909164254.GA25463@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757311AbYIIQyx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080909164254.GA25463@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

On Tue 2008-09-09 17:42:54, Matthew Garrett wrote:
> On Tue, Sep 09, 2008 at 05:29:00PM +0200, Pavel Machek wrote:
> > That's bad then, because ACPI video support does not work here. I can
> > boot, and even Fn-home/end works, but it breaks with X.
> > 
> > In old versions, it resulted on black screen after LID close in X.
> 
> Yeah, X did retarded things in response to video events. That's been 
> fixed for ages.
> 
> > In 2.6.27-rc5, screen goes black as soon as X are started.
> 
> That sounds bizarre, and I can't reproduce it here.

It was same old X. New X fix that. But I still have two backlight devices...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
