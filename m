From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: Critical temp shutdowns on ThinkPad
	X60	1706-GMG
Date: Thu, 31 Jul 2008 11:15:00 -0300
Message-ID: <20080731141500.GD19665@khazad-dum.debian.net>
References: <200807301556.01815.trenn@suse.de>
	<20080730175227.GA13850@khazad-dum.debian.net>
	<87zlnyv14h.fsf_-_@gismo.pca.it> <200807311439.46393.trenn@suse.de>
	<871w1aurwc.fsf@gismo.pca.it> <20080731131512.GI5347@mit.edu>
	<87od4etc6k.fsf@gismo.pca.it> <20080731140602.GB11632@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080731140602.GB11632-3s7WtUTddSA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Theodore Tso <tytso-3s7WtUTddSA@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Luca Capello <luca-wlebWZzHoyE@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 31 Jul 2008, Theodore Tso wrote:
> On Thu, Jul 31, 2008 at 03:28:51PM +0200, Luca Capello wrote:
> > OK, if you want to give a try to my test case:
> > 
> >   $ [install darcs]
> >   $ darcs get http://alioth.debian.org/~gismo/darcs-pull-bug/parenscript.upstream/
> >   $ darcs get http://alioth.debian.org/~gismo/darcs-pull-bug/parenscript/
> >   $ cd parenscript
> >   $ darcs pull ../parenscript.upstream/
> >     [choose to apply only the first patch]
> > 
> > At that point, darcs takes 100% of the CPU and temperature starts to
> > rise :-(
> 
> Hmm.... darcs is not impressing me as a good choice of version control
> systems.  I mean, yes I'm spoiled with git being able to merge
> hundreds of patches is seconds, but this is rediculous!  :-)
> 
> I've tried running for it for a while, and THM0 and THM1 are in the
> 80-83 degree range, but it's not going above that.  According to THM1
> has a passive trip point at 96 degrees, and a critical trip point at
> 100 degrees, but with your test case I'm not going anywhere near that
> level.
> 
> Just for yucks I tried running a second copy of your test case (since
> I hae a dual-core processor), and with the second core also busy 100%,
> I was able to drive the temperature up another degree or two, but that
> was about it.

Well, as a rule, if a recent ThinkPad needs any thermal throttling, it is in
need of repair.  There are exceptions, I suppose.

But really, IBM and Lenovo have never done a very good job on the thermal
sinks.  They break (and sometimes even ship broken from factory) too easily.
It is an extremely difficult (and expensive) thing to get perfect, so that's
not too surprising.  The design is most often good enough, but what you get
in the field often doesn't leave up to the expected design parameters due to
gaps, bad thermal interface glue, cracks in the thermal interface, and
clogged-up fans.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
