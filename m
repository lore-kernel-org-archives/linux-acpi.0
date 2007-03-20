From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: CONFIG_IBM_BAY
Date: Tue, 20 Mar 2007 17:44:25 -0300
Message-ID: <20070320204425.GA29560@khazad-dum.debian.net>
References: <20070315133900.GC26862@khazad-dum.debian.net>
	<20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
	<20070315110156.09e80b99.kristen.c.accardi@intel.com>
	<20070315193123.GB14394@khazad-dum.debian.net>
	<20070319120455.GI11371@thunk.org>
	<20070319232419.GC5932@khazad-dum.debian.net>
	<20070320145722.GB6043@thunk.org>
	<20070320151443.GB13042@khazad-dum.debian.net>
	<20070320184541.GB29493@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070320184541.GB29493-AKGzg7BKzIDYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Theodore Tso <tytso-3s7WtUTddSA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 20 Mar 2007, Theodore Tso wrote:
> On Tue, Mar 20, 2007 at 12:14:43PM -0300, Henrique de Moraes Holschuh wrote:
> > > Maybe, but then the suspend mail have to fail if there are processes
> > > that are keeping the filesystem from being unmounted.  Or the
> > 
> > Yes. But this is standard functionality on the suspend path, anyway.
> 
> The problem with this is that some users will hit the suspend button,
> close the lid, put the laptop into their laptop bag, and then
> immediately head off to the next conference talk (or whatever).  If
> the suspend is going to fail, they might not notice, and they might
> not swap out the bay in any case.  

Well, it needs to be *optional* anyway.  But the above isn't the reason,
though.  Suspend *can* already fail, and anyone who acts like the above
deserves to have to replace their laptop HD more often than those who
actually wait the laptop to be suspended before they toss it into the bag
:-)

> > > processes hanging out on the hard drive or CD-ROM could get all of
> > > their file descriptors revoked on resume, I suppose, if the bay has
> > > been switched out.....
> > 
> > Urk.  It is better to either fail the suspend, or to not power down the bay.
> > Or to give the user a choice of which he'd rather happen.  Hmm...
> 
> Yeah, I think it needs to be configurable.  In many cases the right
> thing to do is for the user to promise not to swap out bay, and in the
> exception case where they do, all of the processes that have files
> open on that bay will have to get their fd's revoked.  We can try to
> make it less likely for there to be data loss, like asking filesystems
> that support write_super_lockfs() to quiesce the filesystem before the
> suspend, but the assumption should be that users aren't supposed to be
> swapping out the bay if they request the suspend code not to
> disconnect the filesystem.

Agreed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
