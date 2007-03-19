From: Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ibm-acpi bay and acpi generic bay convergence
Date: Mon, 19 Mar 2007 11:32:19 -0700
Message-ID: <20070319113219.0ca52dd8.kristen.c.accardi@intel.com>
References: <20070315220414.GC15572@khazad-dum.debian.net>
	<20070317192429.GA6508@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070317192429.GA6508-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 17 Mar 2007 16:24:29 -0300
Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org> wrote:

> On Thu, 15 Mar 2007, Henrique de Moraes Holschuh wrote:
> > 3. is_ejectable_bay is too simple-minded.  It could work for batteries, if it
> > didn't try so hard to detect only sata/ata devices as bays.  Maybe it can be
> > changed to try to detect anything that can be ejected and which is not a
> > dock?  It would find thinkpad batteries, then.
> > 
> > Alternatively, I can use the API I asked for (2) to register the battery bay
> > handler.  But that looks less optimal, right now.
> > 
> > 
> > I need to do some tests to check what happens in a thinkpad when you swap an
> > ATAPI device with a battery, let's hope IBM did the right thing re. the
> > event sources since they have two bay handles that belong to the same bay,
> > and that Lenovo didn't break it.
> 
> Well, I have done the tests.  A quick hack to is_ejectable_bay so that it
> registers anything that is not a dock lets ACPI_BAY handle thinkpad bay
> batteries almost perfectly in a T43.  It is that simple.
> 
> So the first step is to improve is_ejectable_bay.  What reason did you have
> to limit it only to devices where is_ata returns true?  Is there a reason
> why anything that is not a dock and is ejectable should not be handled as a
> bay ?

The only reason the generic bay driver is limited to only ata devices is
simply because that's all I decided to implement for the first revision
of the driver.  So, the perfect time to expand is now :).

Yes - there's a reason why we can't just blindly claim anything ejectable
that isn't a dock.  PCI Hotplug for example.  What I think would be
ideal would be if the bay driver could register for events on anything
ejectable iff no other driver has claimed them.  I couldn't find an easy
way to do this last time I checked (months ago).  Seems like we might have
to change the way ACPI notifications are sent - I was hoping they could be
changed to be more like interrupts - so that you could have a return code
from the notification call that indicates whether the driver handled the
event or not - and allow multiple drivers to register for the same event.
This would also make it possible to eliminate weird stuff like what I'm doing
with the dock driver to allow the bay driver to get dock notifications -
the bay driver could just check to see if it's dependent on another object
using _EJD and then request events on that object as well.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
