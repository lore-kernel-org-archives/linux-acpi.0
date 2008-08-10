From: "S K" <nospamnoham@gmail.com>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Sun, 10 Aug 2008 01:28:00 -0700
Message-ID: <514e099a0808100128u303207clcb22292db2f0cc59@mail.gmail.com>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>
	 <200808081430.43012.trenn@suse.de>
	 <aff5deaf0808081123s1fbe6a5cn7847e9cb053c1f5a@mail.gmail.com>
	 <200808092059.47863.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:45655 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbYHJI2B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Aug 2008 04:28:01 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1128356wri.5
        for <linux-acpi@vger.kernel.org>; Sun, 10 Aug 2008 01:28:00 -0700 (PDT)
In-Reply-To: <200808092059.47863.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Zhao Yakui <yakui.zhao@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, Aug 9, 2008 at 11:59 AM, Thomas Renninger <trenn@suse.de> wrote:
> On Friday 08 August 2008 08:23:25 pm S K wrote:
>> > Try updating the BIOS.
>> > I expect your CPU is too new and the BIOS cannot export the correct freq
>> > values for the specific CPU yet.
>> >
>> >      Thomas
>>
>> The BIOS is already at the latest version :( Is the above comment the
>> only possible reason for the issue?
>
> It is very likely.

But Windows XP is able to do the scaling properly. So how can it be a
BIOS issue? While reading about the Foxconn BIOS fiasco that happened
recently a kernel dev (forgot his name) stated that Linux tries to
emulate Windows for ACPI operations.

So I'm guessing this is a kernel bug.

-SK
