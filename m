Return-Path: <SRS0=f16E=SS=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9B4C10F13
	for <linux-acpi@archiver.kernel.org>; Tue, 16 Apr 2019 09:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD9B20651
	for <linux-acpi@archiver.kernel.org>; Tue, 16 Apr 2019 09:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555405781;
	bh=W6ngLSMgrHr0W3U4Bw4UbqBajEV6+Q7wlh9FAZZkBh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JAiVM1Jwa+O3XBD+72ohv7aPvqrUjJohxeMkzwTPgxf2KZMycE1y7bUIR2R7Z2C74
	 LpCvgccR8V9uefFrNcfZRw5TYMIqWE9ct5Be41YpraDfdChgmvHMN5AP5Wau2gnsXa
	 HwtGvc3m624u8JT35u3X67XzO1/CkTPrrKQpmy8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfDPJJk (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfDPJJk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Apr 2019 05:09:40 -0400
Received: from localhost (unknown [27.5.36.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236FA20645;
        Tue, 16 Apr 2019 09:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555405779;
        bh=W6ngLSMgrHr0W3U4Bw4UbqBajEV6+Q7wlh9FAZZkBh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbEmy3YIoZJbYM+xh03pVXKo0B/ONW0B08iQkD0+49f3EQ7WTkSOUzFc0foEne8c6
         HLWY60V72VYQpM0rfsY1sr7l6UKJXL7xHtWi7sX+gkquBy/Q1UO5Ba9AEFGpqJCadp
         y2Oqmxxm899RJHzpHDrEk0P9Iyx+HDpr7l6cIDrw=
Date:   Tue, 16 Apr 2019 14:39:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        jank@cadence.com, Joe Perches <joe@perches.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: [PATCH] ACPI / device_sysfs: change _ADR representation to 64
 bits
Message-ID: <20190416090935.GT28103@vkoul-mobl>
References: <20190415151857.25531-1-pierre-louis.bossart@linux.intel.com>
 <20190416032923.GQ28103@vkoul-mobl>
 <CAJZ5v0jOkQ7aWn6B_yVTYd7y+78mpGSzBoGuWe3uCdzDRNE94Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jOkQ7aWn6B_yVTYd7y+78mpGSzBoGuWe3uCdzDRNE94Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190416090935.-shcB4zWS06dv9HaBDrUPikVObLqfy_tZXLnRCeY-Rs@z>

On 16-04-19, 10:09, Rafael J. Wysocki wrote:
> On Tue, Apr 16, 2019 at 5:29 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 15-04-19, 10:18, Pierre-Louis Bossart wrote:
> > > Standards such as the MIPI DisCo for SoundWire 1.0 specification
> > > assume the _ADR field is 64 bits.
> > >
> > > _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
> > > released in 2002. The low levels already use _ADR as 64 bits, e.g. in
> > > struct acpi_device_info.
> > >
> > > This patch bumps the representation used for sysfs to 64 bits.
> > >
> > > Example with a SoundWire device, the results show the complete
> > > vendorID and linkID which were omitted before:
> > >
> > > Before:
> > > $ more /sys/bus/acpi/devices/device\:38/adr
> > > 0x5d070000
> > > After:
> > > $ more /sys/bus/acpi/devices/device\:38/adr
> > > 0x000010025d070000
> >
> > This looks fine but the sysfs file is an ABI. Not sure if we can modify
> > the value returned this way.. Though it should not cause userspace
> > reading 32bits to break...
> 
> Well, IIRC using "08" instead of "016" in the format field would
> preserve the existing behavior for 32-bit values, wouldn't it?

Yeah that should do :)

-- 
~Vinod
