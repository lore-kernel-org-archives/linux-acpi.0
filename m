From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and
	getkeycode key table.
Date: Wed, 18 Jul 2007 17:20:28 +0100
Message-ID: <1184775628.2496.1.camel@work>
References: <1184520879991-git-send-email-malattia@linux.it>
	 <11845208791511-git-send-email-malattia@linux.it>
	 <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work>
	 <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work>
	 <20070718114518.GB21658@inferi.kami.home>
	 <20070718142800.GA20607@srcf.ucam.org>
	 <d120d5000707180805u31099be0i2d827b10228d2608@mail.gmail.com>
	 <1184771822.14062.2.camel@work>
	 <d120d5000707180902y6469849mbaba0eaeb81e0578@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.234]:33334 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760870AbXGRQYZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 12:24:25 -0400
Received: by hu-out-0506.google.com with SMTP id 19so261274hue
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jul 2007 09:24:24 -0700 (PDT)
In-Reply-To: <d120d5000707180902y6469849mbaba0eaeb81e0578@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>

On Wed, 2007-07-18 at 12:02 -0400, Dmitry Torokhov wrote:
> What distributions cirrently use the new HAL facilities? I am not
> saying that we want support FC3 but what about FC6, FC7? Ubuntu,
> Debian? 

Currently Fedora and RHEL 5.1 but I believe ubuntu has plans for gutsy.
Basically if you use a new HAL (>=0.5.9), you have to use hal-info.
Distro's will have to comply :-)

Richard.


