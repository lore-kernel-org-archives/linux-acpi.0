From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: acpi-20040715+D600+Suspend
Date: Fri, 10 Sep 2004 16:15:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040910141546.GA29387@message-id.gmane0305.slipkontur.de>
References: <1093972503.9372.38.camel@neuromancer.home.net> <20040902143034.GA676@elf.ucw.cz> <1094442085.21466.29.camel@neuromancer.home.net> <20040906171349.GC26195@atrey.karlin.mff.cuni.cz> <1094527351.25454.14.camel@neuromancer.home.net> <20040907093424.GA30810@atrey.karlin.mff.cuni.cz> <1094768209.2843.6.camel@laptop.cunninghams> <1094811463.27216.117.camel@neuromancer.home.net> <20040910104641.GA24171@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040910104641.GA24171-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 10, 2004 at 12:46:41PM +0200, Pavel Machek wrote:

> All partitions with valuable data :-). Actually, ext2 is even better
> idea. It should work with any filesystem, it is just that ext2/ext3
> has very good filesystem check... And I managed to find bugs even if
> fsck.ext2. You'll probably be luckier, but...

So to lighten the mood here a bit, i'll confess that i have all data
(/ and /home) on reiserfs, only /boot is on ext2 to speed up grub at
resume time (if the filesystem is very dirty at suspend, i guess grub
has to playback the journal in its little mind which can take quite
some seconds for both kernel and initrd).
I have to admit that i do daily backups, though, but this is a good
idea with _any_ filesystem.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
