From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: More experiences with 2.6.13-rc3 with ec_polling patch
Date: Mon, 25 Jul 2005 17:26:53 +0200
Message-ID: <20050725152653.GA18227@tangens.sinus.cz>
References: <20050723133726.GA2079@miro.sinus.cz> <20050724142432.GC1778@elf.ucw.cz> <20050725084044.GA22944@tangens.sinus.cz> <200507251407.55454.rjw@sisk.pl>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200507251407.55454.rjw-KKrjLPT3xs0@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> Hi,
> 
> The problem you describe is not related to the ec_polling patch (see below).
I know. Sorry for bad formulation of the subject, I simply wanted to tell
"more experiences with -rc3 after fixing that one with EC :-)".
> 
> 
> This happens because the sound card should drop the IRQ during
> suspend but it doesn't.  Please try to apply the patch at
> 
> http://bugzilla.kernel.org/attachment.cgi?id=5371&action=view
> 
> and let me know if that helps.
It seems to help just a little:
1) The "Nobody cared" message with the backtrace is still there the same
2) ohci-hcd no more complains about wrong IRQ and inserts/removes OK
... but nevertheless, neither soundcard now USB is working.
Of course I verified that the patch is there in the i8x0 code.
> 
> Greets,
> Rafael
> 
                      With regards, Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
