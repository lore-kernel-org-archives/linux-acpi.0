From: =?iso-8859-1?q?Praveen=20C?= <cpravn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi on r40e
Date: Thu, 19 Feb 2004 14:04:12 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040219140412.85807.qmail@web14522.mail.yahoo.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0025A6413@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0025A6413-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

If I boot with acpi=off, the hotkeys work. I can see the keypress by
watch'ing /dev/nvram. But with acpi, the keys dont work and nothing is
registered in /dev/nvram when any of the hotkeys are pressed. Even
closing and opening the lid causes some change in nvram but nothing is
registered when acpi is enabled.

It looks like hotkeys are accessed through CMOS in Thinkpads.

I dont see any CMOS entry in dsdt table
(http://www.flatface.net/~praveen/tp/acpi/dsdt.dsl).

I am not an expert in this; I am just trying to give all the info I
think might be relevant.

praveen

=====
http://www.cpraveen.tk/

________________________________________________________________________
Yahoo! India Insurance Special: Be informed on the best policies, services, tools and more. 
Go to: http://in.insurance.yahoo.com/licspecial/index.html


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
