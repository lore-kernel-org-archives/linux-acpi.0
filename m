From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: acpi-20040715+D600+Suspend
Date: Fri, 10 Sep 2004 12:46:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040910104641.GA24171@atrey.karlin.mff.cuni.cz>
References: <1093972503.9372.38.camel@neuromancer.home.net> <20040902143034.GA676@elf.ucw.cz> <1094442085.21466.29.camel@neuromancer.home.net> <20040906171349.GC26195@atrey.karlin.mff.cuni.cz> <1094527351.25454.14.camel@neuromancer.home.net> <20040907093424.GA30810@atrey.karlin.mff.cuni.cz> <1094768209.2843.6.camel@laptop.cunninghams> <1094811463.27216.117.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1094811463.27216.117.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Cc: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > For suspend work, ext2 is the safest. I'm now using ext3 on less
> > > important machines -- at least fsck works there.
> > 
> > Ditto here. On the occasions when I have damaged my filesystem, I've had
> > much better success recovering while using ext3. I tried xfs, but gave
> > up on it quickly because of the zeroing-out-files issue.
> Okay.. But here's another question. Is it recommended that _all_
> partitions be ext3 or only the root partition??

All partitions with valuable data :-). Actually, ext2 is even better
idea. It should work with any filesystem, it is just that ext2/ext3
has very good filesystem check... And I managed to find bugs even if
fsck.ext2. You'll probably be luckier, but...

								Pavel


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
