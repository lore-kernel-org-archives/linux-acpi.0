From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/5] ACPI processor: Avoid WARN message on processor
 driver removal
Date: Tue, 17 Jan 2012 07:41:59 -0700
Message-ID: <CAErSpo7Sy4sd_QPWCwSoREyMpyt5yoxvVhOWsgy55hLZf0mMDw@mail.gmail.com>
References: <1321569421-46220-1-git-send-email-trenn@suse.de>
 <1321569421-46220-3-git-send-email-trenn@suse.de> <4F15554F.8040900@kernel.org>
 <201201171525.15937.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50534 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab2AQOmV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 09:42:21 -0500
Received: by wgbdq11 with SMTP id dq11so1989243wgb.1
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 06:42:20 -0800 (PST)
In-Reply-To: <201201171525.15937.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tue, Jan 17, 2012 at 7:25 AM, Thomas Renninger <trenn@suse.de> wrote:
> On Tuesday, January 17, 2012 12:02:39 PM Len Brown wrote:
>> On 11/17/2011 05:36 PM, Thomas Renninger wrote:
> ...
>
>> I think the old cold reads better than the new code,
>> since I don't have to guess what "acpi_idle_active" means...
> Sigh, Bjorn suggested it exactly the other way around.
> I don't mind which way, back to my original post half a year
> ago...

I don't care very much either way.  I think I just thought it was
nicer for the driver to locally remember "I registered, therefore I
should unregister/init new CPUs."  Apparently there can be several
idle drivers, and I don't know what happens if you register more than
one or what cpuidle_get_driver() means in that case.

Bjorn
