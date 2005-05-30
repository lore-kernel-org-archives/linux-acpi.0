From: James Sparenberg <james-q+VOwRQyn90NJZHkBl2fuw@public.gmane.org>
Subject: Re: Re: swsusp: Not enough free pages
Date: Mon, 30 May 2005 10:01:55 -0700
Message-ID: <1117472515.398.26.camel@localhost.localdomain>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
	 <42935C72.9030506@suse.de> <20050525012040.GA6145@linux.sh.intel.com>
	 <20050530091419.GA7922@linux.sh.intel.com>
	 <20050530150157.GC2207@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050530150157.GC2207-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-05-30 at 17:01 +0200, Pavel Machek wrote:
> Hi!
> 
> > > >    > I got this error when I'm hacking suspend-to-disk on my IA64 box
> > > >    with 1G
> > > >    > memory.
> > > >    > (Pagesize 64K,MemTotal:  1002112 kB ,MemFree:  395008 kB)
> > > >    > Do you plan to improve it by compressing pages ?
> > > >    >
> > > >    > swsusp: Need to copy 9878 pages
> > > >    > suspend: (pages needed: 9878 + 512 free: 6486)
> > > >    > swsusp: Not enough free pages: Have 6486
> > > >    I have not seen one of those for a long time (on i386). Does this
> > > >    happen
> > > >    every time? 
> > > 
> > > So far, yes. I just tried 2 times.
> > 
> > always. (I check that swap dev is on)
> > 
> > Sometimes, my ia32 laptop free 0 pages too.
> > I think we should always free some pages 
> > from various caches. 

On other laptops, where ACPI is working for the most part (It does what
the user needs done.)  I've seen this when the user is suspending for
the 3rd or 4th time since the last reboot.  At that point I've found
that if they either 

1.  Power cycle
2.  turn off swap.  run mkswap  turn swap back on 

Then things progress as expected.  The box suspends.  I've also had one
box that had a "dedicated" suspend swap area (The user created a suspend
swap because of something he read) and this box rarely seemed to have
problems of this type.  (Rarely defined as he claims it doesn't happen
very often.)

James



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
