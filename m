From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]
	Samsung P35, S3, black screen (radeon))
Date: Thu, 10 Feb 2005 20:29:47 +0000
Message-ID: <1108067388.4085.74.camel@tyrosine>
References: <1107695583.14847.167.camel@localhost.localdomain>
	 <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi>
	 <1108066096.4085.69.camel@tyrosine>
	 <9e473391050210121756874a84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e473391050210121756874a84@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Bill Davidsen <davidsen@tmr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>, ACPI List <acpi-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-02-10 at 15:17 -0500, Jon Smirl wrote:
> On Thu, 10 Feb 2005 20:08:15 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > It also explicitly states that Windows 2000 and XP don't support this,
> > which leads me to suspect that vendors no longer expect POSTing to be
> > possible after initial system boot.
> 
> No, it means that some of my ATI cards don't function as secondary
> adapters on 2K and XP.

And nor will any other card that requires POSTing (assuming that it
isn't just ATI being less than honest about driver shortcomings). And
we've certainly seen in the past that removing support for functionality
in Windows tends to result in hardware no longer supporting that
functionality.

I have real, shipping hardware here that fails if you simply try to
execute the video BIOS POST code. If you think this is due to a
shortcoming in existing BIOS emulations, I'm more than happy to dump the
video and system BIOS regions and send them to you.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
