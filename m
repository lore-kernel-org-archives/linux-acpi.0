From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: [RFC] Reliable video POSTing on resume
Date: Mon, 7 Feb 2005 15:22:19 +0100
Message-ID: <20050207142219.GC8040@elf.ucw.cz>
References: <20050122134205.GA9354@wsc-gmbh.de> <4204B3C1.80706@rainbow-software.org> <9e473391050205074769e4f10@mail.gmail.com> <200502051748.43547.stefandoesinger@gmx.at> <9e47339105020509382adbbf39@mail.gmail.com> <420740F1.5050609@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420740F1.5050609-CND4fxrytsY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Helge Hafting <helge.hafting-CND4fxrytsY@public.gmane.org>
Cc: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >The problem with the radeon reset code is that there are many, many
> >variations of the radeon chips, including different steppings of the
> >same part. The ROM is matched to the paticular bugs of the chip. From
> >what I know ATI doesn't even have a universal radeon reset program.
> > 
> >
> Maybe they could provide such a program, if asked?
> Basically, a chip detect and a switch statement containing all
> the bios reset sequences they have.
> 
> They may want to protect "trade secrets" about innovative
> 3D-pipelines and such.  But the bios reset is probably not that
> high-end, so perhaps they could provide source code for it?

Try asking them, then ;-)....

Asked the right way, they might even tell you. I believe right way is
"I'd like to buy 10000 cards, but I need suspend-to-RAM to work".

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
