From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: More experiences with 2.6.13-rc3 with ec_polling patch
Date: Tue, 26 Jul 2005 11:36:54 +0200
Message-ID: <200507261136.54824.rjw@sisk.pl>
References: <20050723133726.GA2079@miro.sinus.cz> <200507251846.55852.rjw@sisk.pl> <20050725184827.GA30854@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050725184827.GA30854-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday, 25 of July 2005 20:48, Pavel Troller wrote:
> Hi Rafael!
> > handlers:
> > [<dc86e850>] (snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])
> > 
> > still present in the backtrace with the patch?
> Yes, it was there, but I know why :-), the actual code was patched but it was
> not running, due to the fact that I have about 4 testing kernel trees, 
> something went wrong during modules_install and the old, non-patched sound
> module was used. It works with the modified patch as well as with the original
> one. I feel like an idiot, sorry for this :-).
> > 
>  So the interrupt part of -rc3 problems seems to be fixed for me too :-).

Great.

BTW, can you please send me the output of dmesg from your machine?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
