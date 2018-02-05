From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [Bug 197863] Thinkpad X240 resume dramatically slower on kernels
 4.13+
Date: Mon, 5 Feb 2018 18:06:35 +0100
Message-ID: <a662d85c-e226-223e-3467-90b651dd291b@intel.com>
References: <bug-197863-190391@https.bugzilla.kernel.org/>
 <bug-197863-190391-0fyd51NsnV@https.bugzilla.kernel.org/>
 <20180129182109.neh34gh7uaxymcb5@victor> <20180130063204.GA8652@kroah.com>
 <20180203182554.rpjvmjbptuqemul2@victor> <20180204061804.GB31023@kroah.com>
 <874lmw33fe.fsf@miraculix.mork.no>
 <fe58e542-81c6-9c44-8930-7d91120e80cb@intel.com>
 <87vafbzfoj.fsf@miraculix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35486 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753396AbeBERGk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Feb 2018 12:06:40 -0500
In-Reply-To: <87vafbzfoj.fsf@miraculix.mork.no>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>
Cc: Greg KH <gregkh@linuxfoundation.org>, Markus Demleitner <m@tfiu.de>, Lv Zheng <lv.zheng@intel.com>, Andreas Lindhe <andreas@lindhe.io>, Gjorgji Jankovski <j.gjorgji@gmail.com>, Damjan Georgievski <gdamjan@gmail.com>, Fernando Chaves <nanochaves@gmail.com>, Tomislav Ivek <tomislav.ivek@gmail.com>, "Denis P." <theoriginal.skullburner@gmail.com>, All applicable <stable@vger.kernel.org>, linux-usb@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 2/5/2018 3:14 PM, Bjørn Mork wrote:
> "Rafael J. Wysocki" <rafael.j.wysocki@intel.com> writes:
>> On 2/4/2018 9:28 PM, Bjørn Mork wrote:
>>
>>> But I do wonder if the attached (completely untested!!) patch makes
>>> things any better?
>> I don't think so, the macro is needed too.
> Doh! Obviously.  Don't know how I managed to miss that.
>
>> I'll queue up a full revert of 662591461c4b9a1e3b.
> Still with the additional exception for "ec == first_ec"?
>

No, just a full revert for now.

The above can be fixed on top of that.

Thanks,
Rafael

