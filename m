From: Cameron Patrick <cameron-O6g+VggOkbsyiAr4/NxYnBcLbHmBdUph@public.gmane.org>
Subject: Re: acpi-20040715+D600+Suspend
Date: Tue, 7 Sep 2004 12:38:40 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040907043840.GA8208@cp.yi.org>
References: <1093972503.9372.38.camel@neuromancer.home.net> <20040902143034.GA676@elf.ucw.cz> <1094442085.21466.29.camel@neuromancer.home.net> <20040906171349.GC26195@atrey.karlin.mff.cuni.cz> <1094527351.25454.14.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1094527351.25454.14.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
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

Ow Mun Heng wrote:

> > Hmm, do not use reiserfs ;-).
> Hmm.. isn't reiserfs better?
> I dunno.
> Suse uses it as their root fs.
> I've only switched to reiserfs for my FC2 install. (and frankly, like
> since I went to FC2 3+ months ago, I've had like 3 reiserfs
> --rebuild-checks) compared to like NONE  when I was on RH9/ext3 for ~8
> months.

> What's the majority of ppl using? I know this is Off-topic. sorry..

In my experience, ext3 is the best in terms of not losing any data.  I
tend to use reiserfs because it's faster, though...  I've never had to
do a reiserfs rebuild.

> XFS for my /home 20GB dir. It handles fairly well. (as long as there's
> no sudden power loss, as I read XFS caches the data aggressively and not
> to sync with the disk)

I used to use XFS.  On a few occasions it crashed hard and would
refuse to mount again (needed an xfs_recover).  I ended up with many
corrupted files full of NULL bytes, pretty much every time the machine
lost power or crashed (yay Nvidia drivers) :(

Cameron.



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
