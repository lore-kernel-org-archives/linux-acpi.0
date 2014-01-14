From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RESEND] ACPI: Blacklist Win8 OSI for some HP laptop 2013 models
Date: Tue, 14 Jan 2014 17:53:20 +0100
Message-ID: <4325437.Itfr0xDDg7@vostro.rjw.lan>
References: <1389611658-19424-1-git-send-email-tiwai@suse.de> <6355285.UpbP9PuN7a@vostro.rjw.lan> <20140114163425.GA6649@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140114163425.GA6649@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Takashi Iwai <tiwai@suse.de>, Len Brown <lenb@kernel.org>, Oliver Neukum <oneukum@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, January 14, 2014 04:34:25 PM Matthew Garrett wrote:
> On Tue, Jan 14, 2014 at 05:42:57PM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, January 14, 2014 04:12:44 PM Matthew Garrett wrote:
> > > On Mon, Jan 13, 2014 at 12:14:18PM +0100, Takashi Iwai wrote:
> > > > The BIOS on recent HP laptops behaves differently with Win8 OSI,
> > > > e.g. no backlight control and no rfkill are available.  List them in
> > > > the blacklist as a workaround.
> > > 
> > > What's the plan for fixing this properly?
> > 
> > What exactly do you mean by "fixing this properly"?
> 
> rfkill and backlight control presumably work fine under Windows 8, so 
> there's obviously some new mechanism for doing so. HP will presumably 
> ship more hardware that behaves this way, so if we don't add support for 
> the new mechanisms then we'll just have to keep adding entries to the 
> blacklist.

Well, presumably.

To add any kind of support for anything we need to know how that thing
works in the first place which we don't in this particular case, at least
at the moment.  I hontestly don't want the users of those systems to wait
until we figure that out.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
