From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] X86: Revamp reboot behaviour to match Windows more
 closely
Date: Thu, 09 Dec 2010 14:53:35 -0800
Message-ID: <4D015DEF.9000302@zytor.com>
References: <1291931204-5854-1-git-send-email-mjg@redhat.com> <4D015741.7090500@zytor.com> <20101209223201.GA23894@srcf.ucam.org> <4D015914.1040009@zytor.com> <20101209223847.GA24452@srcf.ucam.org> <4D015ACF.1050105@zytor.com> <20101209225142.GA25215@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101209225142.GA25215@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 12/09/2010 02:51 PM, Matthew Garrett wrote:
> On Thu, Dec 09, 2010 at 02:40:15PM -0800, H. Peter Anvin wrote:
>> On 12/09/2010 02:38 PM, Matthew Garrett wrote:
>>>> Windows doesn't get validated on old hardware.
>>>
>>> XP does this, and older hardware predates the version of the ACPI spec
>>> that introduced this flag.
>>>
>>
>> ACPI is very buggy on early implementations, presumably because WHQL had
>> not yet been extended to include it.  That is exactly why we combine
>> these kinds of things with a date check.
>
> I'm afraid I don't understand your argument. The date cutoff would be on
> the order of 2001 (anything after this will have been tested with XP).
> The spec that defines this behaviour only came into existence in August
> 2000, and any older hardware will be missing the flag that indicates
> that this feature is supported. It doesn't seem realistic to believe
> that there's any real body of hardware that sets the flag but otherwise
> has a broken implementation.
>

2001 is probably a good date, then.

It's pretty safe you'll see the bit being set on systems which are older 
than that, even if it was not defined at the time it was created -- just 
being garbage.  That's par for the course in BIOS land.

	-hpa
