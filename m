From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH]Panasonic Hotkey Driver v0.5 [2/2]
Date: Tue, 24 Aug 2004 19:00:06 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <412BC876.2040300@neggie.net>
References: <41244219.1090603@linuxboxen.org>	<87acwqserw.wl%miura@da-cha.org> <87u0uyqqa7.wl%miura@da-cha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87u0uyqqa7.wl%miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hiroshi Miura wrote:
>  /*
> - *  Panasonic HotKey control Extra driver
> - *  (C) 2004 Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
> - *  (C) 2004 NTT DATA Intellilink Co. http://www.intellilink.co.jp/
> - *  All Rights Reserved
> + *  Panasonic HotKey and lcd brightness control Extra driver
> + *  Written by Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>  2004
> + *
> + *  Copyright (C) 2002-2004 John Belmonte

...

> - *  TODO
> - *	everything all
> + *		- v0.1  start from toshiba_acpi driver written by John Belmonte
>   *
>   */

Thank you for attending to this.  It doesn't seem quite right however, 
since you've removed your own copyright.  Here is what I recommend:

   /*
    *  Panasonic HotKey control Extra driver
    *  (C) 2004 Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
    *  (C) 2004 NTT DATA Intellilink Co. http://www.intellilink.co.jp/
    *
    *  derived from toshiba_acpi.c, Copyright (C) 2002-2004 John Belmonte
    *
    * ...


Regards,
-John


-- 
http://giftfile.org/  ::  giftfile project


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
