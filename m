From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: S3/S4 doesn't work, no-one cares, it's a mess Re: ACPI S3 wake
	howto was: RE: [BKPATCH] ACPI for 2.6
Date: Wed, 31 Mar 2004 13:26:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080732363.4883.964.camel@localhost>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com>
	 <20040330233155.463A.COUNT0@localnet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040330233155.463A.COUNT0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Cc: "Rockefeller, Harry" <harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I can only and simply confirm this very good observation.
It is a quite sad truth that we have to swallow.

For my experience I can say that I am back to recommend using APM for
Linux notebooks where it works and only to use ACPI if APM does not.

On my Asus L3800C with Radeon M8000 (AGP of course) S3 is a simple
no-no. S4 works quite well with a tweaked script stopping and restarting
some drivers before and after swsusp (kernel 2.4).
With kernel 2.6 almost nothing concerning power management works like it
was with 2.4. Not only that behaviour has changed but also things that
worked with 2.4 do not so with 2.6.

I recently bought a Fujitsu Siemens Lifebook B-series device. Very nice
and small. I use it with kernel 2.4 and APM and all I need is working:
Suspend to RAM, suspend to disk. With 2.6 neither ACPI nor APM worked
correctly. The drivers that are now supposed to handle PM events do not
do so properly. Some resume fine, some fail leaving the hardware in a
random state. This happens with 2.6 with ACPI *and* APM.
And for the records, on this machine ACPI S3 almost works, even video
comes back, but fails at random other points (networking causing OOPS,
USB not working anymore until reboot, etc...).

The sutuation is somewhat frightening since this does not seem to change
much during the last year. I do not want to blame anybody for it! Please
get me right.
But this becomes, as Huw already pointed out, a real problem for the
growing Linux laptop userbase.

And I also see that this needs an extra special effort, by many
developers.

So take my word: If I can with my limited experience in PM and x86
hacking be of any help and someone can guide me to a point where I can
start, I will try my very best to improve the situation - at least for
the hardware I have access to.

Best wishes
  nils

Am Mi, den 31.03.2004 schrieb Huw Rogers um 06:51:
> There are 3 competing implementations of S3/S4. None of them work with
> recent AGP ATI Mobility Radeons using ATI's drivers (the most popular
> current video chipset for notebooks / the only driver set that supports
> them properly in X). None of them work with hyperthreaded CPUs or SMP
> (again, hardly exotic). Most USB, Ethernet and other drivers are
> incompatible with S3/S4. The resume code is poorly tested, has race
> conditions, doesn't enable/disable interrupts at the right junctures,
> fails to restore PCI state and does nothing for AGP, USB etc. (left to
> drivers that could care less about suspend/resume).
> 
> I was intent on getting my AGP ATI Radeon/P4 HT/SiS chipset notebook
> working by hacking the code. BUT suspend/resume issues are in ACPI code,
> in power mgmt code, in driver code, in AGP code, in suspend/resume code.
> All owned by different people. Many with competing implementations.
> No-one is a clear leader. The resume itself is near-impossible to debug
> since nothing is alive at that point and the video chipset isn't up.
> 
> Many many people have the problem you describe (lockup on S3 resume,
> need hard power cycle to restart). I have it, and have seen numerous
> other people post on it all with dramatically different hardware. Only
> common factors is that the hardware is recent (i.e. AGP video, typically
> Mobility Radeon), and IT DOESN'T WORK.
> 
> The situation can't be helped by the hacker looking to contribute by
> getting his own gear working (a massive consolidation, refactoring and
> cleanup is required by someone with in-depth knowledge of both ACPI and
> PC hardware). There are also probably deep implications for the Linux
> x86 driver architecture to doing it "properly". Linux vendors put almost
> no effort into supporting laptop hardware despite growing laptop adoption
> in replacement of desktops since their strategy is to get Linux to the
> point that the hardware vendors themselves are compelled to do such work
> like they do for MS Windows. laptop-specific issues such as this receive
> short shrift.
> 
> In short, it's a hopeless mess, no-one who could solve this problem
> really cares about it enough to commission the team required, and it
> requires a huge effort by a couple of gurus with buy-in from Linus & co.
> for the kernel consequences to really fix this.
> 
> Not happening any time soon. Optimize your boot to make it fast instead
> by fooling around with /etc/init.d and company. S3/S4? Bah. -Huw
> 
> > Thanks.


-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
