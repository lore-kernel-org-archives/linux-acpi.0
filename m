From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI, APEI, Add APEI _OSC support
Date: Thu, 16 Jun 2011 08:40:11 +0800
Message-ID: <4DF950EB.7050400@intel.com>
References: <1306303538-30524-1-git-send-email-ying.huang@intel.com> <20110614145246.GA17469@srcf.ucam.org> <4DF82CBC.5070400@intel.com> <20110615121703.GA8638@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110615121703.GA8638@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 06/15/2011 08:17 PM, Matthew Garrett wrote:
> On Wed, Jun 15, 2011 at 11:53:32AM +0800, Huang Ying wrote:
>> Hi, Matthew,
>> On 06/14/2011 10:52 PM, Matthew Garrett wrote:
>>> And then tear down GHES. This seems wrong. A platform could predicate 
>>> APEI functionality on the ACPI spec APEI indication (which we currently 
>>> don't pass) without implementing WHEA, but with this patch we'd refuse 
>>> to enable GHES support? We should probably try both the standard method 
>>> and the WHEA method and only disable GHES if both fail.
>>
>> You means the "APEI Support" bit for standard UUID?  Do you know which
>> machine uses this bit?  I can write the code, but I have no machine to
>> test it.
> 
> I have access to a Dell system that uses this.

Great! Can you help us to test the code?

>> BTW, it is better for us to enable APEI firmware first mode (that is,
>> what is enabled by evaluating the WHEA UUID) after GHES reporting is
>> ready (that is, after GHES module is successfully loaded).  That is
>> later than current ACPI _OSC evaluation with standard UUID.  Is it
>> possible to evaluate _OSC with standard UUID twice?  So that we can
>> enable APEI firmware first mode later.
> 
> Urgh. One machine I've looked at enables APEI if the WHEA _OSC call is 
> made, and then clears a flag if any other _OSC call is made. In that 
> specific case it doesn't seem to matter (the flag never actually gets 
> checked in any of the other codepaths), but it seems that the intention 
> is for the generic call to be made and the WHEA one to be made after 
> that.

Yes.  The WHEA call should be made after the generic one.  Another
situation is as follow:

- Generic _OSC call without "APEI Support" bit is called (in
acpi_bus_osc_support).

- After some time, when we think it is good to turn on firmware first
mode fully, usually after we checking HEST and initializing
corresponding module, we make generic _OSC call with "APEI Support" bit
to turn on firmware first mode fully in standard way.

Is it a good idea to make generic _OSC call twice, one without "APEI
Support" bit, the other with "APEI Support" bit?

Best Regards,
Huang Ying
