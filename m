From: Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Sun, 27 Feb 2005 17:57:01 +0100
Message-ID: <20050227165701.GE1441@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <20050222220828.GB538@hell.org.pl> <20050224123716.GD28961@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224123716.GD28961@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > - DRI must be disabled I guess?! Even with newer X server (x.org)?
> > 
> > You still didn't state which X server are you using. In short, XFree86 4.4,
> 
> I have stated it several times, but here a sum up:
> 
> - XFree86 4.3 (debian/sid) 
> 	no work
> - X.Org 6.8.1.99 (debian -dri-trunk stuff plus kernel modules9
> 	no work
> 	with 2.6.11-rc4 and 2.6.11-rc3-mm2
> 	this server crashes when switching to the console or shutting
> 	down (crashing is sometimes, not always), very nice screen which
> 	slowly turns white

Hmm, it would be nice to be able to trigger "go white" on purpose --
it looks like screen is burning and could scare quite  a lot of people
:-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
