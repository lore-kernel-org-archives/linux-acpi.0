From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Samsung P35, S3, black screen (radeon)
Date: Sat, 5 Feb 2005 10:45:41 +0100
Message-ID: <20050205094541.GE1158@elf.ucw.cz>
References: <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <20050204074302.GA1086@elf.ucw.cz> <1107512396.5727.80.camel@desktop.cunninghams> <20050204161358.GA1290@elf.ucw.cz> <1107555981.4109.3.camel@desktop.cunninghams> <20050205093118.GA1158@elf.ucw.cz> <1107596660.6348.6.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107596660.6348.6.camel-r49W/1Cwd2ff0s6lnCXPXw0QcLn3kwYh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > battery does not run out, you just do resume-from-RAM"? Wow. Nice
> > > > trick...
> > > > 
> > > > But it has same video problems as suspend-to-RAM, no? On how many
> > > > machines does it work?
> > > 
> > > Yes, the same problems as suspend-to-RAM. I'm not sure how many machines
> > > are using it at the moment. I'd love to try it on my laptop; that would
> > > be one more, and I'd also try to get STR working on my HT desktop
> > > machine (Radeon video) if I had the chance. Oh yeah... and I'm going to
> > > have another go at merging. Get the idea I've got a lot I want to do? :>
> > 
> > Actually, getting STR work on SMP/HT machine is going to be quite a
> > lot of work -- because you need to boot secondary CPUs without
> > touching contents of RAM. I hoped CPU hotplug people or Intel ACPI
> > people were going to solve it for me, but unfortunately that did not
> > happen :-(.
> 
> Zwane is working on CPU hotplug. I'm assuming I'll be able to rely on
> his work. He said the other day he was up to testing on x86-64. Are you
> meaning you just haven't seen the code in action, or that you've found
> some reason that hotunplugging won't work?

Last time I checked (long time ago) he did not really put CPU back to
real mode on "unplug"; he just made it spin in protected mode. You can
use his framework, but you really need to boot the cpu from real
mode....
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
