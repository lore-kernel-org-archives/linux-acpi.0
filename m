From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: No S3/S4 response on Toshiba A70 (FC3)
Date: Fri, 11 Feb 2005 12:29:09 +0100
Message-ID: <20050211112909.GA1976@elf.ucw.cz>
References: <20050210181723.GA1577@elf.ucw.cz> <Pine.LNX.4.33.0502102209230.27152-100000@koslx1.triumf.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0502102209230.27152-100000-nuBT7F/NYkeO3qShyYWIeA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gertjan Hofman <gertjan-nuBT7F/NYkeO3qShyYWIeA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Thanks for the response and pointing me to the doc file. I quickly tried
> the standard FC3 non-smp kernel and now S3 goes into suspend but never
> comes back. Not huge surprise. Using a vanilla kernel is a project for the
> weekend. Three questions comes to mind - you point me to the swsusp.txt -
> is this implying S3 will never work ? Secondly, your video.txt doc makes
> it sound like very few video cards can recover from S3. Is this still true
> ?  Lastly, why is a vanilla kernel better than FC3 kernels ? Feel free to
> point me to more documentation.

1) S3 is more tricky than swsusp.

2) actually the list is not so short, but tricks are different for
each card.

3) I do not know about fedora kernel. If you want support on
mainstream mailing lists, you should better use vanilla kernels.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
