From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH] nfit: add a module parameter to ignore ars errors
Date: Thu, 07 Jan 2016 16:31:37 -0500
Message-ID: <568ED939.904@hpe.com>
References: <1451946883-28092-1-git-send-email-vishal.l.verma@intel.com>	<568D4AE6.5020601@hpe.com>	<1452135717.23678.2.camel@kernel.org> <CAPcyv4i3NoioXFRGjyVA=jMOnUw1sx4p7U0_tniRBpo4TJYJiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4621.austin.hp.com ([15.73.212.80]:49448 "EHLO
	g2t4621.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbcAGVbk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2016 16:31:40 -0500
In-Reply-To: <CAPcyv4i3NoioXFRGjyVA=jMOnUw1sx4p7U0_tniRBpo4TJYJiA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On 1/7/2016 12:34 AM, Dan Williams wrote:
> On Wed, Jan 6, 2016 at 7:01 PM, Vishal Verma <vishal@kernel.org> wrote:
>> On Wed, 2016-01-06 at 12:12 -0500, Linda Knippers wrote:
>>> On 1/4/2016 5:34 PM, Vishal Verma wrote:
>>>> Normally, if a platform does not advertise support for Address
>>>> Range
>>>> Scrub (ARS), we skip it. But if ARS is advertised, it is expected
>>>> to
>>>> always succeed. If it fails, we normally fail initialization at
>>>> that
>>>> point.
>>>>
>>>> Add a module parameter to nfit that lets it ignore ARS failures and
>>>> continue with initialization for debugging.
>>>
>>> Could ARS be so broken that you might want to just ignore it
>>> altogether
>>> and not even make the requests?
>>>
>>
>> That is a possibility, and I considered it, but I thought it might be
>> better to see how it fails and then just ignore the errors..
>> It boils down to how much we trust the firmware, and hopefully if it
>> advertises ARS as implemented, it should not be completely broken..
>>
>> Dan, thoughts?
>>
> 
> Hmm, once we add plumbing for bad block clearing / setting we'll have
> the tools to workaround firmware with untrusted ars results.  i.e.
> just manually correct false positive / negative entries.

I was more worried about places where the code is looping waiting
for commands to complete and what happens with buggy firmware
but I've now commented on that patch.  Related to the parameter,
if we think we need to account for buggy firmware, we could be
vulnerable in more places this.

-- ljk

> 

