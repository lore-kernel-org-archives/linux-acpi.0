From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Date: Tue, 1 Mar 2005 13:02:46 +0100
Message-ID: <20050301120246.GM1345@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301015231.091b5329.akpm@osdl.org> <20050301105448.GG1345@elf.ucw.cz> <m1psyjr559.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psyjr559.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, barryn@pobox.com, marado@student.dei.uc.pt, acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Yes, the patch is very ugly. If something like this needs to be done,
> > then perhaps acpi should properly register into driver model and do
> > the work there. This will also mean code will be called consistently.
> 
> I totally agree.  Do you have an example of how a non-device
> can do this?
> 
> In particular something that gets as close to shutting down
> the system devices as possible.  But gets called before that.
> 
> Or perhaps acpi should simply be setup to be the first system device?

I believe that's the prefered solution.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
