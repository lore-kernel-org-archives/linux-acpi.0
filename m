From: Neil Brown <neilb-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>
Subject: Re: How to disable wake-on-Lid Switch
Date: Wed, 9 Mar 2005 11:37:58 +1100
Message-ID: <16942.17766.876120.82187@cse.unsw.edu.au>
References: <16942.11475.596633.415660@cse.unsw.edu.au>
	<1110327508.3663.45.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: message from Nigel Cunningham on Wednesday March 9
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday March 9, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org wrote:
> Hi.
> 
> On Wed, 2005-03-09 at 09:53, Neil Brown wrote:
> > hi,
> >  I have a problem with my notebook. (Dell Latitude D800).
> > 
> >  It suspends and resumes quite nicely (video, audio, etc all work
> >  well) so I'm quite happy.  But there is one little problem.
> > 
> >  The lid-switch seems to be a bit iffy.  Sometimes, while the laptop
> >  is put away snug in it's bag in suspend mode, the lid-switch suddenly
> >  thinks that the lid has been opened.  So it wakes up from suspend and
> >  starts generating heat.  As it is in a nicely padded bag, the heat
> >  doesn't go anywhere, so the temperature goes up up up.
> > 
> >  I would really like the lid button to *Not* resume from suspend.  I
> >  much prefer using the power button to do that.
> 
> I believe /proc/acpi/wakeup might be what you're after:
> 
> [root@desktop root]# cat /proc/acpi/wakeup
> Device  Sleep state     Status
> TANA       4            disabled
> P0P3       4            disabled
> AC97       4            disabled
> USB0       3            disabled
> USB1       3            disabled
> USB2       3            disabled
> USB3       3            disabled
> USB7       3            disabled
> UAR1       4            disabled
> SLPB       4            *enabled

Wow, yes, you are right.

I went hunting back in 2.6.9 and didn't find anything, and when I hit
it again in 2.6.11 I assumed that as the piece of code that I had
patched was still the same, it was still needed.... oops. :-(

> [root@desktop root]# echo SLPB > /proc/acpi/wakeup

So it just toggles.. bit of an unfortunate interface. I need
  grep '^ LID.*\*enabled' /proc/acpi/wakeup > /dev/null  && echo LID > /proc/acpi/wakeup

Thanks heaps.

NeilBrown


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
