From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: Re: acpi bugzilla
Date: Sat, 23 Jul 2005 00:18:58 +0200
Message-ID: <20050722221858.GA3160@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30041F3BFA@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30041F3BFA-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 22, 2005 at 03:03:33PM -0400, Brown, Len wrote:

> Adrian,

Hi Len,

> Thanks for your efforts on bugzilla, I really appreciate it.
> 
> One thing you (and others) might want to know is that for the 
> ACPI category, my team at Intel ignores the bugzilla priority fields.
> The reason is that when we used to change them around to
> reflect what we though priority was, it pissed off a bunch
> of submitters (who all think their bug is most important:-)
> and happy submitters are more productive than unhappy submitters...

I'm currently trying to get the Bugzilla into a working state.

I'm also a bit experimenting.

My impression through both reading linux-kernel and the Bugzilla was 
that there were recently several problems and regressions in the ACPI 
area [1].

One planned step in this direction was have been to ask you:
  "Please review all open 'blocking' and 'high' ACPI bugs, and try to
   get them resolved before 2.6.14 ."

But this implies:
- me reviewing the ACPI bugs and the priorities of them
- getting the number of bugs I'd ask you to review to a manageable
  level (currently there are 42 open 'blocking' and 'high' ACPI bugs,
  which would be too much)

And then I'll do similar things in other areas.

Does this all make sense and will it work?
I don't know, but after I've tried it we'll know.

> I know you're aware, but as a reminder to everybody else...
> I do count on the rule that a bug is never CLOSED until
> the fix has shipped in Linus' tree.  Indeed, I usually
> wait for one of his -rc's before I marked bugs CLOSED
> b/c many users don't pull a new tree until the next -rc.
> 
> Also, any bug that that is marked RESOLVED goes onto
> my list of bug reports to scan to review a patch
> for inclusion.  The patch may be a proposal, it may
> be a hack, but when a patch that works is in the bug
> report, or referenced by the but report, then it
> makes sense to mark the report RESOLVED so the
> patch gets more visibility.  If I the patch doesn't
> make it, then the bug gets marked back to OPEN.

Are you referring to bug 4534?
As I said in my latest comment, closing this bug was a mistake.

If you are referring to something different, please give me an example 
bug number.

> So hopefully we scan every bug and work on them in
> a useful priority.  I admit we haven't don't as good a job
> in the last few months as we did last year -- and much
> of that is my fault.  I'm hopeful that we can get
> the bug reporting/fixing routine working better for
> the rest of this year as we've had it working earlier.
> I'd really like there to be < 100 unresolved bugs
> on the ACPI project, because I can't really keep
> more than that in my head:-)

You ACPI people are already amongst the most active users of the kernel 
Bugzilla. 

> Thanks for your support,
> -Len

cu
Adrian

[1] from a user's point of view
    it doesn't matter how many problems this actually were, and how to
    distribute the "guilt" between the ACPI maintainers and the BIOS 
    authors

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
