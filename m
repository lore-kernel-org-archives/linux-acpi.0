From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: acpi-20040715+D600+Suspend
Date: Mon, 06 Sep 2004 11:41:25 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094442085.21466.29.camel@neuromancer.home.net>
References: <1093972503.9372.38.camel@neuromancer.home.net>
	 <20040902143034.GA676@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040902143034.GA676-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Thu, 2004-09-02 at 22:30, Pavel Machek wrote:
> Hi!
> 
> > 	Lo and Behold, I managed to get S3 to work on my laptop by following
> > instructions on this website.
> > 
> > http://www.loria.fr/~thome/d600/
> > 
> > However, I've not tested it further(as in using the normal kernel boot
> > up line in grub.conf) to verify if it is the same whether or not I use
> > video=radeonfb.
> > 
> > I'm getting these errors during Suspend to disk.
> > 
> > Warning: CPU frequency out of sync: cpufreq and timingcore thinks of 600000, is 1400000 kHz.
> > Debug: sleeping function called from invalid context at mm/slab.c:1989
> > in_atomic():1, irqs_disabled():0
> 
> Turn off CONFIG_PREEMPT. Or better test latest -rcX-mmX.

Hey.. pavel.. thanks to your suggestion, my weekend was wrecked (good
natured sarcasm). I found out the hard way that there rc1-mm1 kernel,
(the only one which worked fairly well) has quite a biting bug that
caused data loss. 

I had my root partition (reiserfs crash), I lost a few trivial files (i
hope) and had to do a rebuild-tree.

After that, it was all downhill, I had rpm errors, my database was
currupted (or so I thought) and tar wouldn't finish on some of those .db
files (I was trying to back up evolution as I anticipated a re-install)

Anyway.. I'm now back on 2.6.8.1 (after finding out that this is a known
bug)

Anyway again, I only found that 2.6.9-rc1-mm1 works in the sense that it
didn't need a "keyboard press for it to initiate writing/suspend to
disk"

All the rest didn't work. That's meaning 2.6.9/2.6.9-rc1-mm2/2.6.8.1

I see that 2.6.9-rc1-mm3 is out, I will test it. (hopefully it doen't
bite)
 
> 										Pavel

-- 
Ow Mun Heng
Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel 2.6.8.1.Aug.29 
Neuromancer 11:18:26 up 1:05, 6 users, load average: 1.54, 0.90, 0.52 


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
