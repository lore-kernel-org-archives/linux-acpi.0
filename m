From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH v3 1/3] acpi: Call acpi_os_prepare_sleep hook in
 reduced hardware sleep path
Date: Wed, 26 Jun 2013 16:45:53 +0100
Message-ID: <51CB28D102000078000E0DF8@nat28.tlf.novell.com>
References: <1372255575-29567-1-git-send-email-benjamin.guthro@citrix.com>
 <1372255575-29567-2-git-send-email-benjamin.guthro@citrix.com>
 <51CB19C602000078000E0D75@nat28.tlf.novell.com>
 <CAOvdn6V0TJRF6r_2=CETPsiqawMpKxos+rCn8+aQ+SqU2p1WiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:52992 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab3FZPp4 convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:6:1>);
	Wed, 26 Jun 2013 11:45:56 -0400
In-Reply-To: <CAOvdn6V0TJRF6r_2=CETPsiqawMpKxos+rCn8+aQ+SqU2p1WiQ@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Guthro <benjamin.guthro@citrix.com>
Cc: Bob Moore <robert.moore@intel.com>, xen-devel@lists.xen.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafaell J . Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

>>> On 26.06.13 at 17:03, Ben Guthro <benjamin.guthro@citrix.com> wrote:
> On Wed, Jun 26, 2013 at 10:41 AM, Jan Beulich <JBeulich@suse.com> wrote:
>>>>> On 26.06.13 at 16:06, Ben Guthro <benjamin.guthro@citrix.com> wrote:
>>> In version 3.4 acpi_os_prepare_sleep() got introduced in parallel with
>>> reduced hardware sleep support, and the two changes didn't get
>>> synchronized: The new code doesn't call the hook function (if so
>>> requested). Fix this, requiring a parameter to be added to the
>>> hook function to distinguish "extended" from "legacy" sleep.
>>>
>>> Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>
>> I think these are intended to reflect the flow of things, so
>> should be reversed (also in the other patches).
>>
>>> --- a/drivers/acpi/acpica/hwesleep.c
>>> +++ b/drivers/acpi/acpica/hwesleep.c
>>> @@ -43,6 +43,7 @@
>>>   */
>>>
>>>  #include <acpi/acpi.h>
>>> +#include <linux/acpi.h>
>>
>> This also got complaints, so I'd be very surprised if they took it now.
> 
> I did see these complaints in the last version.
> However, the file drivers/acpi/acpica/hwsleep.c contains this include,
> and has since
> 
> commit 09f98a825a821f7a3f1b162f9ed023f37213a63b
> Author: Tang Liang <liang.tang@oracle.com>
> Date:   Fri Dec 9 10:05:54 2011 +0800
> 
> So since this is the extended sleep file, vs the standard one - I
> don't see why such a restriction would be placed on the former, but
> not the latter.

In essence they said (in the same thread I pointed you to) that
according to the current policy this include is wrong and should
be dropped.

Now, if you can get along without dropping it that'll likely be fine,
but I doubt they'll allow you to add another instance of this.

Jan

