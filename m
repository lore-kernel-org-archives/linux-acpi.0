From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH]Panasonic Hotkey Driver
Date: Wed, 18 Aug 2004 10:52:23 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41236D27.1080804@neggie.net>
References: <87d62cxnud.wl%miura@da-cha.org> <1092805474.25902.126.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1092805474.25902.126.camel@dhcppc4>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, letsnote-tech-eXqGM+LsbTTAqL8d+zIrHngSJqDPrsil@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:
> Ah yes, another battle in the war on hot-keys;-)
> 
> On Sat, 2004-07-31 at 10:17, Hiroshi Miura wrote:
> 
>>+/*
>>+ *  Panasonic HotKey control Extra driver
>>+ *  (C) 2004 Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
>>+ *  (C) 2004 NTT DATA Intellilink Co. http://www.intellilink.co.jp/
>>+ *  All Rights Reserved
>>+ *
>>+ *  This program is free software; you can redistribute it and/or
>>modify
>>+ *  it under the terms of the GNU General Public License version 2 as
>>+ *  publicshed by the Free Software Foundation.
>>+ *
>>+ *  This program is distributed in the hope that it will be useful,
>>+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>+ *  GNU General Public License for more details.
>>+ * *  You should have received a copy of the GNU General Public
>>License
>>+ *  along with this program; if not, write to the Free Software
>>+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
>>02111-1307  USA
>>+ *
>>+ *  The devolpment page for this driver will be located at
>>+ *  http://www.da-cha.org/
>>+ *
>>+
>>*---------------------------------------------------------------------------
>>+ *
>>+ * ChangeLog:
>>+ *     Jul.25, 2004    Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
>>+ *             - v0.4  first post version
>>+ *             -       add debug function to retrive SIFR
>>+ *
>>+ *     Jul.24, 2004    Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
>>+ *             - v0.3  get proper status of hotkey
>>+ *
>>+ *      Jul.22, 2004   Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
>>+ *             - v0.2  add HotKey handler
>>+ *
>>+ *      Jul.17, 2004   Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
>>+ *             - v0.1  based on acpi video driver
>>+ *
> 
> 
> would be polite to credit the exact files that you leveraged.

I think it's a little beyond a politeness issue.  Large verbatim blocks 
of toshiba_acpi.c are used, with my copyright notice nowhere in sight.

-John


-- 
http://giftfile.org/  ::  giftfile project


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
