From: Gertjan Hofman <gertjan-nuBT7F/NYkeO3qShyYWIeA@public.gmane.org>
Subject: Re: No S3/S4 response on Toshiba A70 (FC3)
Date: Thu, 10 Feb 2005 22:14:29 -0800 (PST)
Message-ID: <Pine.LNX.4.33.0502102209230.27152-100000@koslx1.triumf.ca>
References: <20050210181723.GA1577@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050210181723.GA1577-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Pavel,

Thanks for the response and pointing me to the doc file. I quickly tried
the standard FC3 non-smp kernel and now S3 goes into suspend but never
comes back. Not huge surprise. Using a vanilla kernel is a project for the
weekend. Three questions comes to mind - you point me to the swsusp.txt -
is this implying S3 will never work ? Secondly, your video.txt doc makes
it sound like very few video cards can recover from S3. Is this still true
?  Lastly, why is a vanilla kernel better than FC3 kernels ? Feel free to
point me to more documentation.

Thanks

Gertjan


On Thu, 10 Feb 2005, Pavel Machek wrote:

> Hi!
>
>
> > Bunch more facts: I run FC3, kernel 2.6.10-1.741_FC3smp. I have also
>                                                    ~~~~~~ <- use
> 					vanilla kernel and avoid SMP
>
> Read documentation/power/swsusp.txt.
> 								Pavel
>

-- 
//////////////////////////////////////////////////////////////////////////
work    :   604-982-3574
E-mai l :   gertjan-K9O0zq5Arhf3fQ9qLvQP4Q@public.gmane.org
web     :   http://koslx1.triumf.ca/gertjan
//////////////////////////////////////////////////////////////////////////



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
