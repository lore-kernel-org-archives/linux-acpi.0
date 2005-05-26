From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Wed, 25 May 2005 21:23:57 -0700
Message-ID: <20050525212357.0b28cbb3.akpm@osdl.org>
References: <200503291156.19112.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200503291156.19112.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
>
> Hi,
> 
> There is a problem on my box (Asus L5D, x86-64 kernel) with the ACPI battery
> driver in the 2.6.12-rc1-mm[1-3] kernels.  Namely, the battery monitor that
> I use (the kpowersave applet from SUSE 9.2) is no longer able to report the
> battery status (ie how much % it is loaded).  It can only check if the AC power
> is connected (if it is connected, kpowersave behaves as though there was
> no battery in the box, and if it is not connected, kpowersave always shows
> that the battery is 1% loaded).
> 
> Also, there are big latencies on loading and accessing the battery module, but
> the module loads successfully and there's nothing suspicious in dmesg.
> 

Are these problems still present in 2.6.12-rc5 or 2.6.12-rc5-mm1?


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
