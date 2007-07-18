From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and
	getkeycode key table.
Date: Wed, 18 Jul 2007 16:17:02 +0100
Message-ID: <1184771822.14062.2.camel@work>
References: <1184520879991-git-send-email-malattia@linux.it>
	 <11845208793678-git-send-email-malattia@linux.it>
	 <11845208794064-git-send-email-malattia@linux.it>
	 <11845208791511-git-send-email-malattia@linux.it>
	 <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work>
	 <20070716180928.GA21211@srcf.ucam.org> <1184668653.2443.2.camel@work>
	 <20070718114518.GB21658@inferi.kami.home>
	 <20070718142800.GA20607@srcf.ucam.org>
	 <d120d5000707180805u31099be0i2d827b10228d2608@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.235]:60020 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757515AbXGRPVC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 11:21:02 -0400
Received: by hu-out-0506.google.com with SMTP id 19so242801hue
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jul 2007 08:21:00 -0700 (PDT)
In-Reply-To: <d120d5000707180805u31099be0i2d827b10228d2608@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>

On Wed, 2007-07-18 at 11:05 -0400, Dmitry Torokhov wrote:
> 
> I think we should continue adding keymaps to kernel until everyone is
> using HAL's facilities to load keymaps and then stop. Does this make
> sense? 

I don't think so. The whole idea of hal-info is that we can update a 14k
noarch package every week if needed, that will work on pretty much any
hal version.

I'm not sure people running FC3 systems are going to be running git
kernels for new keymaps.

Richard.


