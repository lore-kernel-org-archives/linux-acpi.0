From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3, SuSE Linux 9.1, Dell Dimension 8300
Date: Mon, 3 Jan 2005 18:09:54 +0100
Message-ID: <20050103170954.GA1429@elf.ucw.cz>
References: <1104275510.41d1e83630f26@webmail.telering.at> <200412292109.55022.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200412292109.55022.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stefan Lintner <stefan.lintner-OBssYPn7tLPk7+2FdBfRIA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I am using SuSE Linux 9.1 and would like to use S3 on my home Dell
> > Dimension 8300 desktop PC. S3 works fine in WinXP.
> >
> > Unfortunately the SuSE handbook says that S3 is currently not
> > supported on Intel Pentium 4 HT systems. There are also problems if
> > AGP modules are loaded - I have such a module loaded: \"intel_mch_agp\"
> >
> > System:
> > Dell Dimension 8300, A07 Bios
> > Intel 875P chipset, Intel Pentium 4 HT 2,6GHz
> > 1024MB RAM
> > NVidia GeforceFX 5200
> > Maxtor 6Y080LO HDD
> >
> > If I press the power button the PC shuts down.
> >
> > Is it possible to use S3 on this machine?
> >
> Did you try echo 3  > /proc/acpi/sleep

I'd say "bad idea on SMP system". Boot nosmp, then try it.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
