From: nicdev05 nic <nicdev05-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Driver Testing
Date: Wed, 16 Mar 2005 18:43:04 -0800 (PST)
Message-ID: <20050317024304.95595.qmail@web31402.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: 6667
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Thanks Jason,
  Setting a wake time by writing to /proc/acpi/alarm
returns with an error - "No Installed handler for
fixed event". This is to be expected I guess since I
don't have a resume command attached to the wake
timer.

  So, any idea as what the resume command should be? I
a Fedora Core-2 system.

  Outside of resume, the suspend process works fine
(by writing to /sys/power/state). If I press the power
button the system seems to resume but then follows
with a reboot...

Any ideas? Thanks..
-Nic


--- Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>, Jason Dagit
<dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org> wrote:
> nicdev05 nic <nicdev05-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> writes:
> 
> > Folks,
> >   I am adding power management support to a
> network
> > driver on Linux 2.6. I have a simple question, is
> > there a tool I can use to test my PM support?
> > Something that will put my PC (Dell Optiplex) to
> sleep
> > and wakes it up after say 1-minute?
> 
> You may want to try this:
> 
> http://acpi.sourceforge.net/documentation/alarm.html
> 
> Jason
> 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
