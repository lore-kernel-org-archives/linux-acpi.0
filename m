From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 15/16] ACPICA: _CST repair: Handle null package entries
Date: Mon, 17 Jun 2013 22:31:44 +0200
Message-ID: <51BF7230.4040805@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com> <f941986213920b382a8f43af43caec298cd16a5a.1369274559.git.lv.zheng@intel.com> <CAJvTdKm06aCeLvV28=TSrv5wqoapUY0vh2=ppY5p5pFW0pUKFw@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88016@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16670 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab3FQUbt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jun 2013 16:31:49 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88016@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On 6/17/2013 6:41 PM, Moore, Robert wrote:
> This one is just adding additional checks on the _CST that are obvious errors in the AML. The eventual goal of the "repair" code in ACPICA is to never return a bad package from things like _CST. In other words, an AE_OK guarantees that the return value is usable.
>
> So, this is an additional implementation of this longer-range project.
>

Thanks Bob!

Lv, care to add the above explanation from Bob to the changelog of the 
$subject patch?

Rafael


>> -----Original Message-----
>> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
>> Sent: Wednesday, June 12, 2013 11:00 AM
>> To: Zheng, Lv
>> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
>> Subject: Re: [PATCH 15/16] ACPICA: _CST repair: Handle null package
>> entries
>>
>> On Fri, Jun 7, 2013 at 9:01 PM, Lv Zheng <lv.zheng@intel.com> wrote:
>>> Sort package only after null/bad elements have been removed.
>>> Lv Zheng.
>>
>> again, please explain WHY.
>>
>> Every line of change to the kernel adds risk.
>> I see no justification in this commit message why any risk should be added
>> to the kernel.
>>
>> Nacked-by: Len Brown <len.brown@intel.com>

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
z siedziba w Gdansku
ul. Slowackiego 173
80-298 Gdansk

Sad Rejonowy Gdansk Polnoc w Gdansku, 
VII Wydzial Gospodarczy Krajowego Rejestru Sadowego, 
numer KRS 101882

NIP 957-07-52-316
Kapital zakladowy 200.000 zl

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

