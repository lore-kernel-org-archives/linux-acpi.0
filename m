From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: acpi-20040715+D600+Suspend
Date: Tue, 07 Sep 2004 11:22:31 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094527351.25454.14.camel@neuromancer.home.net>
References: <1093972503.9372.38.camel@neuromancer.home.net>
	 <20040902143034.GA676@elf.ucw.cz>
	 <1094442085.21466.29.camel@neuromancer.home.net>
	 <20040906171349.GC26195@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040906171349.GC26195-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-09-07 at 01:13, Pavel Machek wrote:
> Hi!
> 
> > > Turn off CONFIG_PREEMPT. Or better test latest -rcX-mmX.
> > 
> > Hey.. pavel.. thanks to your suggestion, my weekend was wrecked (good
> > natured sarcasm). I found out the hard way that there rc1-mm1 kernel,
> > (the only one which worked fairly well) has quite a biting bug that
> > caused data loss. 
> 
> Sorry for that.

As I mentioned. it was good natured sarcasm.
I'm back on 2.6.7 with the interactive patch and an old acpi code.

Just an update, I've tried 2.6.9 yesterday, still had the irq_disabled
problem. (though did not need a keyboard press to activate writing to
swap)

2.6.9-rc1-mm3 compiled OK once i8042 is patched (or reversed patched)
but it won't perform modules_install. Problem with "ln" and multiple
directories.


> 
> > I had my root partition (reiserfs crash), I lost a few trivial files (i
> > hope) and had to do a rebuild-tree.
> 
> Hmm, do not use reiserfs ;-).
Hmm.. isn't reiserfs better?
I dunno.
Suse uses it as their root fs.
I've only switched to reiserfs for my FC2 install. (and frankly, like
since I went to FC2 3+ months ago, I've had like 3 reiserfs
--rebuild-checks) compared to like NONE  when I was on RH9/ext3 for ~8
months.

What's the majority of ppl using? I know this is Off-topic. sorry..


XFS for my /home 20GB dir. It handles fairly well. (as long as there's
no sudden power loss, as I read XFS caches the data aggressively and not
to sync with the disk)

-- 
Ow Mun Heng
Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel
2.6.7-2.jul1-interactive 
Neuromancer 11:15:19 up 3:04, 7 users, load average: 1.38, 0.84, 0.64 


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
