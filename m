From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Samsung P35, S3, black screen (radeon)
Date: Sat, 05 Feb 2005 20:51:33 +1100
Message-ID: <1107597093.6348.11.camel@desktop.cunninghams>
References: <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>
	 <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <20050204074302.GA1086@elf.ucw.cz>
	 <1107512396.5727.80.camel@desktop.cunninghams>
	 <20050204161358.GA1290@elf.ucw.cz>
	 <1107555981.4109.3.camel@desktop.cunninghams>
	 <20050205093118.GA1158@elf.ucw.cz>
	 <1107596660.6348.6.camel@desktop.cunninghams>
	 <20050205094541.GE1158@elf.ucw.cz>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050205094541.GE1158-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Sat, 2005-02-05 at 20:45, Pavel Machek wrote:
> Hi!
> 
> > > > > battery does not run out, you just do resume-from-RAM"? Wow. Nice
> > > > > trick...
> > > > > 
> > > > > But it has same video problems as suspend-to-RAM, no? On how many
> > > > > machines does it work?
> > > > 
> > > > Yes, the same problems as suspend-to-RAM. I'm not sure how many machines
> > > > are using it at the moment. I'd love to try it on my laptop; that would
> > > > be one more, and I'd also try to get STR working on my HT desktop
> > > > machine (Radeon video) if I had the chance. Oh yeah... and I'm going to
> > > > have another go at merging. Get the idea I've got a lot I want to do? :>
> > > 
> > > Actually, getting STR work on SMP/HT machine is going to be quite a
> > > lot of work -- because you need to boot secondary CPUs without
> > > touching contents of RAM. I hoped CPU hotplug people or Intel ACPI
> > > people were going to solve it for me, but unfortunately that did not
> > > happen :-(.
> > 
> > Zwane is working on CPU hotplug. I'm assuming I'll be able to rely on
> > his work. He said the other day he was up to testing on x86-64. Are you
> > meaning you just haven't seen the code in action, or that you've found
> > some reason that hotunplugging won't work?
> 
> Last time I checked (long time ago) he did not really put CPU back to
> real mode on "unplug"; he just made it spin in protected mode. You can
> use his framework, but you really need to boot the cpu from real
> mode....

Okay. I already have it spinning in protected mode for Suspend2, so that
wouldn't be a gain. I'm pretty sure though that he's seen my current
code and believes his is a gain :> We'll see...

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
