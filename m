From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Samsung P35, S3, black screen (radeon)
Date: Fri, 4 Feb 2005 17:13:58 +0100
Message-ID: <20050204161358.GA1290@elf.ucw.cz>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net> <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <20050204074302.GA1086@elf.ucw.cz> <1107512396.5727.80.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107512396.5727.80.camel-r49W/1Cwd2ff0s6lnCXPXw0QcLn3kwYh@public.gmane.org>
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

> > > > > Pavel, what do you think?
> > > > 
> > > > Well, calling BIOS using vm86 is going to be quite a lot of code. If
> > > > it is self-contained and not too huge, it is probably okay. It should
> > > > help with quite a lot of cards, but who knows...
> > > > 
> > > > Yes, it is probably worth trying.
> > > 
> > > I'd love to see it too. Pavel, even if you don't want to merge it for a
> > > while, we can always incorporate it in the Suspend2 patches so it gets
> > > some testing. I know I'd try it on my i830 based Omnibook.
> > 
> > You mean using suspend2 as test branch for suspend-to-RAM, too? Okay,
> > why not.... It would be nice if suspend-to-RAM stuff was kept on the
> > begining of the series so it does not become dependend on
> > suspend-to-DISK parts....
> 
> Well, we already have support for entering S3 instead of powering down
> (makes for faster resume if the battery doesn't run out)... and I have
> to get Suspend2 interacting with these patches as well.

Is it like "suspend to disk, but end with suspend-to-RAM, so that if
battery does not run out, you just do resume-from-RAM"? Wow. Nice
trick...

But it has same video problems as suspend-to-RAM, no? On how many
machines does it work?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
