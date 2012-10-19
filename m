From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: Re: [PATCH V3 0/3] PNP: Allow PNP resources to be disabled (interface)
Date: Fri, 19 Oct 2012 21:02:20 +0200
Message-ID: <5081A3BC.9050201@gmx.net>
References: <50158321.4030007@gmx.net> <201208022340.16948.rjw@sisk.pl> <5055DFB6.6070809@gmx.net> <201209182342.30244.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201209182342.30244.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Borislav Petkov <bp@alien8.de>, bhelgaas@google.com, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 18/09/12 23:42, Rafael J. Wysocki wrote:

> Hi,
> 
> On Sunday, September 16, 2012, Witold Szczeponik wrote:
>> Hi Rafael, 
>>
>> what about the patches 1 and 3 which do not make any changes to the ABI?
>> The first patch simplifies the code, while the third patch fixes a problem in
>> the PNP resource allocation.  Any chances to have them included in 3.7?
> 
> They would be fine as far as I'm concerned, but I'm not maintaining that part
> of the kernel (at least at the moment).
> 
> I'm not sure who's the maintainer of it, to be honest.

Well, according to https://lkml.org/lkml/2012/10/19/375, that would be you
(together with Bjorn and Len).  :-)  Hence I am resending the request for
inclusion to you as well.  PNP code went, if I am not mistaken, traditionally
through Len's tree.  

--- Witold

> 
> Thanks,
> Rafael
> 
