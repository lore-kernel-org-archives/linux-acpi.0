From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][ACPI] AC/DC notifier
Date: Fri, 14 Aug 2009 18:32:33 +0200
Message-ID: <20090814163233.GC1626@ucw.cz>
References: <FFAE0590FF35E441901B67BD8BA62E950245ABD9@storexmb3.amd.com> <20090812005532.GA31003@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755086AbZHOQUw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090812005532.GA31003@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Tippett, Matthew" <Matthew.Tippett@amd.com>, "Langsdorf, Mark" <mark.langsdorf@amd.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Li, Samuel" <Samuel.Li@amd.com>
List-Id: linux-acpi@vger.kernel.org

On Wed 2009-08-12 01:55:32, Matthew Garrett wrote:
> On Tue, Aug 11, 2009 at 08:51:49PM -0400, Tippett, Matthew wrote:
> 
> >    From a graphics perspective (your area of expertise), this will allow KMS
> >    drivers to do some more intelligent actions based on the ac/dc state. 
> >    Some examples of this could be improving the power consumption of the
> >    graphics hardware through adapting clock memory/engine settings for
> >    reduced power consumption, reducing refresh rate of the display to reduce
> >    scanout memory access, adjusting backlight brightness, etc.
> 
> Right. As you say, my concern is that most of this should belong in 
> userspace. Where we risk hardware damage there's an obvious argument for 
> doing this in kernel, but we should ensure that that's limited to 
> whatever coarse-grain handling is absolutely required rather than doing 
> things like touching display brightness.

Yep... Some may want to save power even when AC is online -- like when
running on UPS. Some may want max performmance even on battery. 
								Pavel 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
