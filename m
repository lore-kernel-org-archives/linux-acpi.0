From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: DSDT Change (Compaq Presario 2100)
Date: Fri, 2 Jul 2004 21:21:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040702192152.GB10138@elf.ucw.cz>
References: <200405280621.29874.andre@eisenbach.com> <c9am7j$nng$1@sea.gmane.org> <200405291345.51712.andre@eisenbach.com> <20040628213409.GA19468@elf.ucw.cz> <cbsi0v$t1r$1@sea.gmane.org> <20040702115454.GA12889@elf.ucw.cz> <40E59C64.9050603@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40E59C64.9050603-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Cc: Erik Meitner <usenet-cuDg6iFcrsRAfugRpC6u6w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Thanks for the heads up on this, Pavel!
> 
> I did unplug my batter, started an updatedb and compiled firefox, 
> coreutils and a new kernel. The battery got warm, but not hot. 
> Definitely not more then when charging it.
> 
> A curious (unrelated) observation:
> The ACPI thermal zone temperature indicated about 68 C at most  on 
> battery doing this. However, when the battery was drained and I plugged 
> the AC back in, the temperature rose and stayed at about 75 C and the 
> fans worked audibly harder. This continued even after I removed the 
> battery, so it's not the additional heat from the charging.
> I wonder if something else is throttled when on battery. It's not the 
> CPU though as benchmarks dont slow down on battery anymore after my DSDT 
> change.

Strange... It could be backlight, but that does not produce enough
heat...


> As far as the DSDT change goes. Pavel, do you think that the kind of 
> throtteling they do is an effective way to limit battery current draw?
> I am getting more battery life now - even with powernow at "performance".

If you are getting more battery life now... well it looks like bios
vendor did something very wrong.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
