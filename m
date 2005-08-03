From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 and S4 broken on Toshiba Satellite 2400-s201
Date: Wed, 3 Aug 2005 07:36:05 +0200
Message-ID: <20050803053605.GA1399@elf.ucw.cz>
References: <200507301545.29522.ziuchkov@uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200507301545.29522.ziuchkov-e94Sedi4moU@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bob Z <ziuchkov-e94Sedi4moU@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Hello, I am new to this mailing list, so please bear with me.  I've been 
> having a heck of a time getting everything working with my laptop.  It's a 
> Toshiba Satellite 2400-s201.  I finally got my alps touchpad and my wifi card 
> to work after days of fussing around with different kernel and patch 
> versions.  I ended up with version 2.6.11 of the linux kernel because neither 
> 2.6.8(.1) nor 2.6.12 would work with my touchpad.  Now everything works 
> except for suspend to ram and suspend to disk.  All of the rest of the ACPI 
> modules work fine for me.  I can poll my battery, scale my cpu

You really need to be running latest kernel if you want to do some
debugging. 2.6.13-rc4 is latest, if alps does not work, talk with
vojtech about fixing it.
							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
