From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Samsung P35, S3, black screen (radeon)
Date: Sat, 05 Feb 2005 09:26:21 +1100
Message-ID: <1107555981.4109.3.camel@desktop.cunninghams>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>
	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <20050204074302.GA1086@elf.ucw.cz>
	 <1107512396.5727.80.camel@desktop.cunninghams>
	 <20050204161358.GA1290@elf.ucw.cz>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050204161358.GA1290-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Sat, 2005-02-05 at 03:13, Pavel Machek wrote:
> Hi!
> 
> > > > > > Pavel, what do you think?
> > > > > 
> > > > > Well, calling BIOS using vm86 is going to be quite a lot of code. If
> > > > > it is self-contained and not too huge, it is probably okay. It should
> > > > > help with quite a lot of cards, but who knows...
> > > > > 
> > > > > Yes, it is probably worth trying.
> > > > 
> > > > I'd love to see it too. Pavel, even if you don't want to merge it for a
> > > > while, we can always incorporate it in the Suspend2 patches so it gets
> > > > some testing. I know I'd try it on my i830 based Omnibook.
> > > 
> > > You mean using suspend2 as test branch for suspend-to-RAM, too? Okay,
> > > why not.... It would be nice if suspend-to-RAM stuff was kept on the
> > > begining of the series so it does not become dependend on
> > > suspend-to-DISK parts....
> > 
> > Well, we already have support for entering S3 instead of powering down
> > (makes for faster resume if the battery doesn't run out)... and I have
> > to get Suspend2 interacting with these patches as well.
> 
> Is it like "suspend to disk, but end with suspend-to-RAM, so that if
> battery does not run out, you just do resume-from-RAM"? Wow. Nice
> trick...
> 
> But it has same video problems as suspend-to-RAM, no? On how many
> machines does it work?

Yes, the same problems as suspend-to-RAM. I'm not sure how many machines
are using it at the moment. I'd love to try it on my laptop; that would
be one more, and I'd also try to get STR working on my HT desktop
machine (Radeon video) if I had the chance. Oh yeah... and I'm going to
have another go at merging. Get the idea I've got a lot I want to do? :>

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
