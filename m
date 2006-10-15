From: "Mathew Brown" <mathewbrown@fastmail.fm>
Subject: Re: Preventing ACPI from Damaging Your CPU
Date: Sun, 15 Oct 2006 07:16:48 -0700
Message-ID: <1160921808.22526.273369924@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44750 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1160995AbWJOOQs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Oct 2006 10:16:48 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

So just to re-iterate, even if you recompile the DSDT so that it
compiles without any errors, there's no guarantee that ACPI won't
kill/damage your processor unless the vendor has something special that
can't be over-ridden by ACPI (such as is the case with HP's newer
motherboards/processors).  So how does Windows manage to get around this
issue?  From my limited understanding of ACPI, the problems seem to be
due to the compilation of the DSDT with the Microsoft Compiler which
Linux would have trouble dealing with because it's too lack on what gets
through.  Am I understanding this issue properly?  Thanks for your help.

Rafael J. Wysocki wrote:
> On Friday, 13 October 2006 06:56, Mathew Brown wrote:
>> Thanks.  But is 80C safe for a CPU?  As I mentioned, 70C is considered
>> dangerous for an Opteron chip.  What type of temperatures can the
>> Turions and the C2D support?
>
> I think HP would force the fan at lower temperatures if 80C were considered
> as dangerous ....
>
> Greetings,
> Rafael
>
>
>> On Fri, 13 Oct 2006 05:53:39 +0100, "Matthew Garrett"
>> <mjg59@srcf.ucam.org> said:
>>> On Thu, Oct 12, 2006 at 09:41:15PM -0700, Mathew Brown wrote:
>>>> Thanks Matthew.  Just out of curiosity, how did you find out about this
>>>> feature (forcing the fan at 80C)?  Also, is this specific to HP or do
>>>> other vendors also support this?  Finally, is 80C safe for the CPU
>>>> (Intel or AMD?)?  I read that Opteron chips could be damaged if their
>>>> temperature reaches 70C.  Thanks for your help.
>>> A certain amount of reverse engineering of HP hardware while I was 
>>> trying to diagnose some fan problems before. The fan control chip that 
>>> HP use is pretty standard, so I think there are docs around somewhere.
>>>
>>> -- 
>>> Matthew Garrett | mjg59@srcf.ucam.org
>> -- 
>>   Mathew Brown
>>   mathewbrown@fastmail.fm
>>
>

-- 
  Mathew Brown
  mathewbrown@fastmail.fm

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow

