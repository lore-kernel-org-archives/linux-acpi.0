From: Berthold Cogel <cogel@rrz.uni-koeln.de>
Subject: Re: Regression in kernel linux-2.6.20-rc1/2: Problems with poweroff
Date: Sun, 11 Feb 2007 23:01:53 +0100
Message-ID: <45CF9251.1040003@rrz.uni-koeln.de>
References: <459069AA.20809@rrz.uni-koeln.de> <45999C47.40204@rrz.uni-koeln.de> <20070102190722.GT20714@stusta.de> <200702052228.34264.lenb@kernel.org> <20070206034620.GB27397@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932572AbXBKWDc@vger.kernel.org>
In-Reply-To: <20070206034620.GB27397@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Adrian Bunk schrieb:
> On Mon, Feb 05, 2007 at 10:28:34PM -0500, Len Brown wrote:
>>> On Tue, Jan 02, 2007 at 12:41:59AM +0100, Berthold Cogel wrote:
>>>>>> 'shutdown -h now' doesn't work for my system (Acer Extensa 3002 WLMi)
>>>>>> with linux-2.6.20-rc kernels. The system reboots instead.
>>>>>> I've checked linux-2.6.19.1 with an almost identical .config file
>>>>>> (differences because of new or changed options). For pre 2.6.20 kernels
>>>>>> shutdown works for my computer.
>> Try CONFIG_USB=n
> 
> CONFIG_USB_SUSPEND=n is most likely enough.
> 
> That's an unfixed 2.6.20-rc regression reported more than once, the 
> first time in December last year...
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=7945
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7828
> 
>> -Len
> 
> cu
> Adrian
> 

Hi!

CONFIG_USB_SUSPEND=n does the job. But the patch from
http://bugzilla.kernel.org/show_bug.cgi?id=7828#c29 works for my system
too (with CONFIG_USB_SUSPEND=y). The bugreport was made for an ACER
Travelmate 4001 WMLi, which is almost identical to my Acer Extensa 3002
WLMi.


Regards,
Berthold
