From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Date: Tue, 1 Mar 2005 13:08:43 +0100
Message-ID: <20050301120843.GN1345@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301015231.091b5329.akpm@osdl.org> <m1u0nvr5cn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u0nvr5cn.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, barryn@pobox.com, marado@student.dei.uc.pt, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > In `subj` kernel, machine no longer powers down at the end of
> > >  swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.
> > 
> > Binary searching indicates that this is due to
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/broken-out/acpi_power_off-bug-fix.patch.
> > 
> > 
> > I'll drop it.  That patch is pretty ugly-looking anyway (ACPI code in
> > drivers/base/power/?).
> > 
> > Perhaps someone who is hitting the problem which that patch addresses could
> > raise a bugzilla entry.
> > 
> > Oh.  It has one.  http://bugme.osdl.org/show_bug.cgi?id=4041
> > 
> > Anyway.  It needs more work.
> 
> Agreed.
> 
> I threw it together to test a specific code path, and the fact it
> fails in software suspend is actually almost confirmation that I am on
> the right track.  This actually fixed the case I was testing.
> 
> In this case the failure is simply because system_state is
> not set to SYSTEM_POWER_OFF before
> kernel/power/disk.c:power_down() calls device_shutdown().
> The appropriate reboot notifier is also not called..

Can you suggest patch to do it right? Or perhaps there should be
just_plain_power_machine_down() that does all neccessary
trickery?
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
