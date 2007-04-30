From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.21: ACPI related kernel panic
Date: Mon, 30 Apr 2007 14:46:00 +0200
Message-ID: <6bffcb0e0704300546w1eff1a92gff047117e9e756e@mail.gmail.com>
References: <20070430122940.GA25848@anna.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:62864 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423209AbXD3MqC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Apr 2007 08:46:02 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1900414nzf
        for <linux-acpi@vger.kernel.org>; Mon, 30 Apr 2007 05:46:01 -0700 (PDT)
In-Reply-To: <20070430122940.GA25848@anna.darkstar.lan>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Kemper <sebastian_ml@gmx.net>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 30/04/07, Sebastian Kemper <sebastian_ml@gmx.net> wrote:
> Hello all,
>
> I have updated some different boxes to 2.6.21 with success. One laptop,
> though, has some issue with it.
>
> It's an Acer TravelMate 4002WLMi. Sometimes it boots fine and sometimes
> not. Thanks to netconsole you can see what happens when it boots fine in
> the attached bootsie.out.good. bootsie.out shows what happens on the
> screen when things get out of hand (kernel panic).
>
> Also attached you'll find the output of lspci, lsusb, ver_linux and the
> kernel configuration.
>
> If there's more you need (git bisection or more info in general,
> testing ...) just say so.
>
> Thanks in advance!
>
> Regards
> Sebastian
>
> P.S.: Please CC.
>
>

I added this to the list of known regressions.

Len and ACPI folks CC'ed.

Regards,
Michal

-- 
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
