From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Date: Tue, 1 Mar 2005 11:54:48 +0100
Message-ID: <20050301105448.GG1345@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301015231.091b5329.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301015231.091b5329.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, barryn@pobox.com, marado@student.dei.uc.pt, "Eric W. Biederman" <ebiederm@xmission.com>, acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > In `subj` kernel, machine no longer powers down at the end of
> >  swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.
> 
> Binary searching indicates that this is due to
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/broken-out/acpi_power_off-bug-fix.patch.
> 
> I'll drop it.  That patch is pretty ugly-looking anyway (ACPI code in
> drivers/base/power/?).
> 
> Perhaps someone who is hitting the problem which that patch addresses could
> raise a bugzilla entry.
> 
> Oh.  It has one.  http://bugme.osdl.org/show_bug.cgi?id=4041
> 
> Anyway.  It needs more work.

Yes, the patch is very ugly. If something like this needs to be done,
then perhaps acpi should properly register into driver model and do
the work there. This will also mean code will be called consistently.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
