From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] thermal active cooling step
Date: Tue, 22 Jun 2004 19:37:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040622173707.GA26555@elf.ucw.cz>
References: <6E0C289723A0564F9A8279E236E8565F078052FF@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6E0C289723A0564F9A8279E236E8565F078052FF-4yWAQGcml64divtuJNk2fFDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Qiang, Mike" <mike.qiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zhu, Yi" <yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> I have a question about thermal active cooling process that we do 
> in acpi_thermal_active. 
> For example, if _AC0 is lower than current temperature, we set maxtemp
> to _AC0's temperature then turn it on. Next step is checking _AC1, if
> _AC1 
> is also lower than current, we turn it on by ignore maxtemp in current
> code.
> 
> According to the Spec, _AC0 should be greater than _AC1's cooling
> strength.
> (If two fans are in system, AC0 includes both two and AC1 may include
> one of them)
> So i think the variable maxtemp seems not be used properly here.
> 
> Pls, see my patch attached. And correct me if I am wrong.

At least indentation is very wrong. Plus please include patches in the
text, *not* as attachments.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
