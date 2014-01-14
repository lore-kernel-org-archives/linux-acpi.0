From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RESEND] ACPI: Blacklist Win8 OSI for some HP laptop 2013 models
Date: Tue, 14 Jan 2014 17:42:57 +0100
Message-ID: <6355285.UpbP9PuN7a@vostro.rjw.lan>
References: <1389611658-19424-1-git-send-email-tiwai@suse.de> <20140114161244.GD4307@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140114161244.GD4307@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Takashi Iwai <tiwai@suse.de>, Len Brown <lenb@kernel.org>, Oliver Neukum <oneukum@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, January 14, 2014 04:12:44 PM Matthew Garrett wrote:
> On Mon, Jan 13, 2014 at 12:14:18PM +0100, Takashi Iwai wrote:
> > The BIOS on recent HP laptops behaves differently with Win8 OSI,
> > e.g. no backlight control and no rfkill are available.  List them in
> > the blacklist as a workaround.
> 
> What's the plan for fixing this properly?

What exactly do you mean by "fixing this properly"?

Rafael
