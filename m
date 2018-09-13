From: Brice Goglin <brice.goglin@gmail.com>
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
Date: Thu, 13 Sep 2018 06:51:38 +0100
Message-ID: <4f253bf4-ef2d-849f-b793-9b0530e72aab@gmail.com>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <f8dc2958-a7c7-a633-3a06-97fed7c3510b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f8dc2958-a7c7-a633-3a06-97fed7c3510b@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>, Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vkilari@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

Le 12/09/2018 à 11:49, Sudeep Holla a écrit :
>
>> Yes.  Without this change, we hit the lscpu error in the commit message,
>> and get zero output about the system.  We don't even get information
>> about the caches which are architecturally specified or how many cpus
>> are present.  With this change, we get what we expect out of lscpu (and
>> also lstopo) including the cache(s) which are not architecturally
>> specified.
>>
> lscpu and lstopo are so broken. They just assume everything on CPU0.
> If you hotplug them out, you start seeing issues. So reading and file
> that doesn't exist and then bail out on other essential info though they
> are present, hmmm ...

Can you elaborate?

I am not sure cpu0 is supposed to be offlineable on Linux. There's no
"online" file in /sys/devices/system/cpu/cpu0. That's why former lstopo
doesn't like CPU0 being hotplugged out. We are actually making that case
work for another non-standard corner case. But offlining "cpu0" this is
considered "normal", somebody must add that missing "online" sysfs
attribute for "cpu0" (change
https://elixir.bootlin.com/linux/latest/source/drivers/base/cpu.c#L375).

By the way, did anybody actually see an error with lstopo when there's
no "type" attribute for L3? I can't reproduce any issue, we just skip
that specific cache entirely, but everything else appears. If you guys
want to make that "no_cache" cache appear, I'll make it a Unified cache
unless you tell me what to show :)

Brice
