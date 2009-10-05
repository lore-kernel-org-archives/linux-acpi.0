From: Stefan Bader <stefan.bader@canonical.com>
Subject: Re: [Fwd: Re: [PATCH] acerhdf: Limit modalias matching to supported
 boards]
Date: Mon, 05 Oct 2009 14:05:54 +0200
Message-ID: <4AC9E122.8050609@canonical.com>
References: <4AC9E0F3.5030605@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050003000606070004030900"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:45081 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758558AbZJEMGd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2009 08:06:33 -0400
In-Reply-To: <4AC9E0F3.5030605@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@gmail.com>, Peter Feuerer <peter@piie.net>

This is a multi-part message in MIME format.
--------------050003000606070004030900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stefan Bader wrote:
> Len,
> 
> could you please pick this patch to prevent the acerhdf module to get 
> loaded on the wrong hardware (causing only annoying warnings.
> 
> Thanks,
> Stefan
> 
> -------- Original Message --------
> Subject: Re: [PATCH] acerhdf: Limit modalias matching to supported boards
> Date: Sat, 03 Oct 2009 18:47:33 +0200
> From: Peter Feuerer <peter@piie.net>
> To: Stefan Bader <stefan.bader@canonical.com>
> CC: Borislav Petkov <petkovbb@googlemail.com>, linux-kernel@vger.kernel.org
> References: <4AC34B83.6090402@canonical.com> 
> <20090930212233.GB17712@liondog.tnic> 
> <cone.1254466252.404216.3290.1000@onepiie> 
> <4AC5B0F1.4030303@canonical.com> 
> <9ea470500910020254j21fad1d3g1c825bcecdbb29fb@mail.gmail.com> 
> <cone.1254477850.9043.3499.1000@onepiie> <4AC5D098.1010504@canonical.com>
> 
> Stefan Bader writes:
> 
>> Peter Feuerer wrote:
>>> Borislav Petkov writes:
>>>
>>>> On Fri, Oct 2, 2009 at 9:51 AM, Stefan Bader 
>>>> <stefan.bader@canonical.com> wrote:
>>>>>>> I search my acerhdf-inbox for the people who sent me the BIOS 
>>>>>>> versions,
>>>>>> maybe they still have the netbook and can me send the modalias 
>>>>>> content. I'll
>>>>>> hopefully find some time upcoming weekend.
>>>>>>
>>>>>> But, can't we simply assume, following dmi lines?
>>>>>>
>>>>>> MODULE_ALIAS("dmi:*:*Acer*:*AOA*:");
>>>>>> MODULE_ALIAS("dmi:*:*Gateway*:*AOA*:");
>>>>>> MODULE_ALIAS("dmi:*:*Packard Bell*:*AOA*:");
>>>>>> MODULE_ALIAS("dmi:*:*Packard Bell*:*DOA*:");
>>>>>>
>>>>>> We have exactly those constellations within the BIOS settings 
>>>>>> table. If I
>>>>>> interpret the modalias line correctly, "pnAOA110" means "Product Name
>>>>>> AOA110" and that's what we have already in the BIOS settings 
>>>>>> table. So I
>>>>>> think we do already have all information we need to create a 
>>>>>> complete patch
>>>>>> for the problem, or am I wrong?
>>>>>
>>>>> Right pn means that. I would strongly believe the above changes 
>>>>> should be
>>>>> good. I sometimes tend to be over-cautious. Attaching a refreshed 
>>>>> patch
>>>>> which includes them all.
>>>>
>>>> Well, acerhdf.c and dmi-id.c both do
>>>> dmi_get_system_info(DMI_PRODUCT_NAME) when querying product name which
>>>> means that the product names in the acerhdf table and the dmi-id ones
>>>> are actually one and the same thing.
>>>>
>>>> IMO, we should just go ahead send it to Len. Stefan, you have my ACK.
> 
> Acked-by: Peter Feuerer <peter@piie.net>
> 
> Thank you Stefan!
> 
> regards,
> --peter
> 

Doh! This time _with_ the patch...



-- 

When all other means of communication fail, try words!



--------------050003000606070004030900
Content-Type: text/x-diff;
 name="0001-acerhdf-Limit-modalias-matching-to-supported-boards.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-acerhdf-Limit-modalias-matching-to-supported-boards.pat";
 filename*1="ch"

>From 60cdb7bea856fdd594262ee1e9608cd2210cf196 Mon Sep 17 00:00:00 2001
From: Stefan Bader <stefan.bader@canonical.com>
Date: Mon, 28 Sep 2009 17:11:29 +0000
Subject: [PATCH] acerhdf: Limit modalias matching to supported boards

BugLink: https://bugs.launchpad.net/ubuntu/+bug/435958

The module alias currently matches any Acer computer but when loaded the
BIOS checks will only succeed on Aspire One models. This causes a invalid
BIOS warning for all other models (seen on Aspire 4810T).
This is not fatal but worries users that see this message. Limiting the
moule alias to models starting with AOA or DOA for Packard Bell.

Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
Acked-by: Borislav Petkov <petkovbb@gmail.com>
Acked-by: Peter Feuerer <peter@piie.net>
---
 drivers/platform/x86/acerhdf.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 0a8f735..23eea4c 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -629,9 +629,10 @@ static void __exit acerhdf_exit(void)
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Peter Feuerer");
 MODULE_DESCRIPTION("Aspire One temperature and fan driver");
-MODULE_ALIAS("dmi:*:*Acer*:*:");
-MODULE_ALIAS("dmi:*:*Gateway*:*:");
-MODULE_ALIAS("dmi:*:*Packard Bell*:*:");
+MODULE_ALIAS("dmi:*:*Acer*:pnAOA*:");
+MODULE_ALIAS("dmi:*:*Gateway*:pnAOA*:");
+MODULE_ALIAS("dmi:*:*Packard Bell*:pnAOA*:");
+MODULE_ALIAS("dmi:*:*Packard Bell*:pnDOA*:");
 
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
-- 
1.5.4.3


--------------050003000606070004030900--
