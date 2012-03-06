From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH v3 0/4] toshiba_acpi: Expanded hotkey support
Date: Mon, 05 Mar 2012 16:55:46 -0800
Message-ID: <4F556092.7060202@xenotime.net>
References: <1326915852-19896-1-git-send-email-seth.forshee@canonical.com> <20120206150658.GE6414@ubuntu-macmini> <20120206151548.GA30255@srcf.ucam.org> <20120305220407.GA16312@ubuntu-macmini> <4F5545BB.5010608@xenotime.net> <20120305233445.GD16312@ubuntu-macmini>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20120305233445.GD16312@ubuntu-macmini>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Len Brown <lenb@kernel.org>, Azael Avalos <coproscefalo@gmail.com>, Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 03/05/2012 03:34 PM, Seth Forshee wrote:

> On Mon, Mar 05, 2012 at 03:01:15PM -0800, Randy Dunlap wrote:
>> On 03/05/2012 02:04 PM, Seth Forshee wrote:
>>
>>> On Mon, Feb 06, 2012 at 03:15:48PM +0000, Matthew Garrett wrote:
>>>> On Mon, Feb 06, 2012 at 09:06:58AM -0600, Seth Forshee wrote:
>>>>
>>>>> Matthew: Just wondering if there are more issues that need to be
>>>>> addressed with this round of patches, or if they're looking okay at this
>>>>> point.
>>>>
>>>> I'm fine with them at this point, just waiting on Len to give feedback 
>>>> on the ACPI patch.
>>>
>>> Well, I've been trying to get some comment on the ACPI patch, to no
>>> avail. Unless there's some other option, I guess I'll just resend the
>>> patches using an alternative method for getting the EC handle.
>>
>>
>> I did test this patch series on 3.3-rc5 to see if it would
>> help with the touchpad on/off key on my Toshiba Portege.
>>
>> The patch series didn't have any ill effects, nor did it help
>> with the touchpad on/off key.  :(
> 
> Is it only that hotkey that doesn't work, or do the others fail to work
> as well?

I haven't tried any others.  Which ones do you suggest that I test?

> If it's only that key that doesn't work, I'd suggest using input-events
> to determine exactly which device the other hotkey events are coming
> from (it might be more than one) and to verify there really isn't any
> event coming out for that key. If there's no event at all for the key,
> check dmesg and see if any messages are printed there when you press the
> touchpad key.


I don't know about "input-events".  Where do I find it & info on it?

I already tried using 'showkey' and it didn't see any keypress for the
touchpad key.

thanks,
-- 
~Randy
