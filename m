From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v2 3/9] ACPI: introduce acpi_table_parse2()
Date: Mon, 15 Feb 2016 15:57:33 +0300
Message-ID: <56C1CB3D.6070906@linaro.org>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
 <1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
 <20160212185130.GA10095@kroah.com>
 <CAJZ5v0ji3rR3HkC7BjygkqXxOrEn3qSKA42i1Rj9tBqZ71Dh+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34330 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbcBONDK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2016 08:03:10 -0500
Received: by mail-lf0-f48.google.com with SMTP id j78so88473290lfb.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2016 05:03:09 -0800 (PST)
In-Reply-To: <CAJZ5v0ji3rR3HkC7BjygkqXxOrEn3qSKA42i1Rj9tBqZ71Dh+w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>

Hi Rafael, 

Thank you for review.

On 02/13/2016 02:08 AM, Rafael J. Wysocki wrote:
> On Fri, Feb 12, 2016 at 7:51 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Fri, Feb 12, 2016 at 08:43:34PM +0300, Aleksey Makarov wrote:
>>> The function acpi_table_parse() has some problems:
>>> 1 It can be called only from __init code
>>> 2 It does not pass any data to the handler
>>> 3 It just throws out the value returned from the handler
>>>
>>> These issues are addressed in this patch
>>
>> Why not just fix acpi_table_parse(), like you have, and not add a new
>> API call with a "2" at the end of it.  That seems crazy to try to
>> maintain that level of apis.
>>
>> But I'm not the acpi maintainer(s), so it's their call...
> 
> The ACPI maintainer agrees.

I see. 

How would you prefer it to be fixed:

1. Change the signature/implementation of acpi_table_parse(). 
CON: It would require extensive changes through all the kernel,
which I am not sure I will be able to test (but these changes are
just adding an unused arg to the handler + checking that the 
return value is consistent)

OR

2. Have a local implementation of the function like acpi_table_parse2()
CON: A bit of code duplication.

Thank you
Aleksey Makarov
