From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI: add "auto" to acpi_enforce_resources
Date: Tue, 24 Mar 2009 14:21:21 +0100
Message-ID: <49C8DE51.2010103@redhat.com>
References: <alpine.LFD.2.00.0902040042570.9833@localhost.localdomain>	 <498953DF.5050306@redhat.com> <20090204131708.GA2739@srcf.ucam.org>	 <20090204142606.1823661b@hyperion.delvare>	 <20090204142015.GB3923@srcf.ucam.org>	 <20090210145716.105ab58b@hyperion.delvare>	 <20090210140829.GA25397@srcf.ucam.org> <49919E08.5050002@redhat.com>	 <20090210172408.400cacee@hyperion.delvare>	 <20090227132740.GF1482@ucw.cz> <68676e00903240539i119b6d26j516ee131d4cd6781@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47721 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756897AbZCXNUw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Mar 2009 09:20:52 -0400
In-Reply-To: <68676e00903240539i119b6d26j516ee131d4cd6781@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>



On 03/24/2009 01:39 PM, Luca Tettamanti wrote:
> On Fri, Feb 27, 2009 at 2:27 PM, Pavel Machek<pavel@ucw.cz>  wrote:
>> Hi!
>>
>>>> For the record we have changed the default to strict in Fedora's
>>>> development branch, for 2 weeks or so now, including in the recently
>>>> released Fedora 11 release and we've had 0 complaints so far.
>>> Well, if the number of affected systems is small, this is good news.
>>> But this is only 2 weeks and one distribution, coverage isn't
>>> sufficient to claim anything yet IMHO.
>>>
>>> That being said... if there's a common consensus that switching to
>>> strict and dealing with fallouts is the best thing to do, and I'm the
>>> only one objecting to this, then I am ready to admit that I was wrong
>>> and let you proceed.
>> I believe that 'enable strict, deal with fallout' is the best
>> long-term strategy...
>
> Hello,
> the merge window for .30 is now open, what are we going to do with this issue?
>

I think the consensus was to make the default strict and to merge the atk0110
driver, right?

Note that we've been running this setup in Fedora kernels for quite a while now,
and have had only one bug report, which was solved by simply explaining why this
was done.

Regards,

Hans
