From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH V2] ACPI/Battery: Add a _BIX quirk for NEC LZ750/LS
Date: Wed, 15 Jan 2014 00:17:56 -0600
Message-ID: <52D62814.2000401@gmail.com>
References: <1389019837-13619-1-git-send-email-tianyu.lan@intel.com> <1793775.ULjNzyMivD@vostro.rjw.lan> <20140114160601.GB4307@srcf.ucam.org> <5255063.SeYbBZqxVQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:41743 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaAOGR7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2014 01:17:59 -0500
In-Reply-To: <5255063.SeYbBZqxVQ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Lan Tianyu <tianyu.lan@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, fcr@adinet.com.uy, l@dorileo.org

On 01/14/2014 03:37 PM, Rafael J. Wysocki wrote:
> On Tuesday, January 14, 2014 04:06:01 PM Matthew Garrett wrote:
>> On Mon, Jan 06, 2014 at 11:25:53PM +0100, Rafael J. Wysocki wrote:
>>
>>> Queued up as a fix for 3.13 (I fixed up the indentation).
>>
>> Ah, sorry, I missed this chunk of the thread. If the system provides
>> valid _BIF data then we should possibly just fall back to that rather
>> than adding another quirk table.
>
> The problem is to know that _BIX is broken.  If we could figure that out
> upfront, we woulnd't need the quirk table in any case.
>
> Tianyu, can we do some effort during the driver initialization to detect
> this breakage and handle it without blacklisting systems?

Yes, the usual question in such cases is "how does Windows manage to 
function on such systems, (almost certainly) without a system-specific 
hack, and can we replicate that behavior?"

