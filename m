From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: acpi-20040715+D600+Suspend
Date: Fri, 10 Sep 2004 18:17:43 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094811463.27216.117.camel@neuromancer.home.net>
References: <1093972503.9372.38.camel@neuromancer.home.net>
	 <20040902143034.GA676@elf.ucw.cz>
	 <1094442085.21466.29.camel@neuromancer.home.net>
	 <20040906171349.GC26195@atrey.karlin.mff.cuni.cz>
	 <1094527351.25454.14.camel@neuromancer.home.net>
	 <20040907093424.GA30810@atrey.karlin.mff.cuni.cz>
	 <1094768209.2843.6.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1094768209.2843.6.camel-AdgCB+f5QAxwBzq2CxEN2SkBHpOjBR89@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-09-10 at 18:06, Nigel Cunningham wrote:
> Hi.
> 
> On Tue, 2004-09-07 at 19:34, Pavel Machek wrote:
> > > > > I had my root partition (reiserfs crash), I lost a few trivial files (i
> > > > > hope) and had to do a rebuild-tree.
> > > > Hmm, do not use reiserfs ;-).
> > > Hmm.. isn't reiserfs better?
> > > I dunno.
> > > Suse uses it as their root fs.
> > > I've only switched to reiserfs for my FC2 install. (and frankly, like
> > > since I went to FC2 3+ months ago, I've had like 3 reiserfs
> > > --rebuild-checks) compared to like NONE  when I was on RH9/ext3 for ~8
> > > months.
> > > 
> > > What's the majority of ppl using? I know this is Off-topic. sorry..
> > 
> > For suspend work, ext2 is the safest. I'm now using ext3 on less
> > important machines -- at least fsck works there.
> 
> Ditto here. On the occasions when I have damaged my filesystem, I've had
> much better success recovering while using ext3. I tried xfs, but gave
> up on it quickly because of the zeroing-out-files issue.
Okay.. But here's another question. Is it recommended that _all_
partitions be ext3 or only the root partition??

-- 
Ow Mun Heng
Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel
2.6.7-2.jul1-interactive 
Neuromancer 18:17:08 up 22:56, 8 users, load average: 2.17, 2.72, 2.64 


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
