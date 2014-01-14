From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH RESEND] ACPI: Blacklist Win8 OSI for some HP laptop
 2013 models
Date: Tue, 14 Jan 2014 16:42:27 +0000
Message-ID: <20140114164227.GA7752@srcf.ucam.org>
References: <1389611658-19424-1-git-send-email-tiwai@suse.de>
 <6355285.UpbP9PuN7a@vostro.rjw.lan>
 <20140114163425.GA6649@srcf.ucam.org>
 <4325437.Itfr0xDDg7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4325437.Itfr0xDDg7@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Takashi Iwai <tiwai@suse.de>, Len Brown <lenb@kernel.org>, Oliver Neukum <oneukum@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 14, 2014 at 05:53:20PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, January 14, 2014 04:34:25 PM Matthew Garrett wrote:
> > rfkill and backlight control presumably work fine under Windows 8, so 
> > there's obviously some new mechanism for doing so. HP will presumably 
> > ship more hardware that behaves this way, so if we don't add support for 
> > the new mechanisms then we'll just have to keep adding entries to the 
> > blacklist.
> 
> Well, presumably.
> 
> To add any kind of support for anything we need to know how that thing
> works in the first place which we don't in this particular case, at least
> at the moment.  I hontestly don't want the users of those systems to wait
> until we figure that out.

Adding blacklist entries without making some effort to figure out what 
the underlying problem is doesn't provide any incentive for fixing the 
underlying problem. In this case Toshio has described what the problem 
is and it sounds like fixing the rfkill problem is straightforward, so 
we should just classify this in the same way as all the other backlight 
control issues. Perhaps we should add it to the native video blacklist 
rather than the OSI one?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
