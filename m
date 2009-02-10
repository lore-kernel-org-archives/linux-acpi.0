From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Oopses and ACPI problems (Linus 2.6.29-rc4)
Date: Tue, 10 Feb 2009 15:45:33 +0000
Message-ID: <20090210154533.GA27596@srcf.ucam.org>
References: <alpine.LFD.2.00.0902081251090.3048@localhost.localdomain> <gemini.ket9w800w44dc0hvg.linux@youmustbejoking.demon.co.uk> <20090209234911.GB862@elte.hu> <5030E21460%linux@youmustbejoking.demon.co.uk> <20090210150431.GA26798@srcf.ucam.org> <5030E7CFF4%linux@youmustbejoking.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753885AbZBJPpx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5030E7CFF4%linux@youmustbejoking.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-f>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 10, 2009 at 03:15:21PM +0000, Darren Salt wrote:

> As things stand, this is likely to be a problem for anybody using lenny on
> Eee hardware and upgrading (on their own) to 2.6.29, given that that
> workaround is present in eeepc-acpi-scripts in lenny.
> 
> Anyway, removing that option fixes the problem.

Ok. I'll look into ensuring that these don't collide, but fundamentally 
the problem here is distributions using broken options rather than 
fixing the problem properly in the first place.

> > BIOS bug. There's an explicit delay in the eee bios for some reason, and 
> > I haven't found any straightforward way to avoid it.
> 
> BIOS bug or no, the fact remains that this is (AFAICS) a regression.

You don't get properly working hotkeys otherwise, to the best of my 
recollection. There's an entry on the kernel bugzilla about this 
somewhere.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
