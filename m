From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [BUG] ACPI resource validation not working [Was: Re: ITE 8728F]
Date: Wed, 30 Nov 2011 10:07:37 +0100
Message-ID: <20111130100737.0c2be76b@endymion.delvare>
References: <CAKPcRGofYw_DcVL1QDorSp8Gr1ZL6-ur=oZnDs0w_e91ZuwKbQ@mail.gmail.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E316EE2575@ORSMSX101.amr.corp.intel.com>
	<1322531323.1467.10.camel@minggr>
	<CAKPcRGpXP=A-WHVLyvf_ZazY8br5d4-CxrDpnCbpJbcsnMVpiQ@mail.gmail.com>
	<CAF1ivSZyvzOY9DGWEgSwrcbyPQ9ftOGbO9VAwcDk-V4=Utxk0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:27685 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161Ab1K3JH4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Nov 2011 04:07:56 -0500
In-Reply-To: <CAF1ivSZyvzOY9DGWEgSwrcbyPQ9ftOGbO9VAwcDk-V4=Utxk0g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Nikolay Mikov <nik.mikov@gmail.com>, Thomas <trenn@suse.de>, linux-acpi@vger.kernel.org

On Tue, 29 Nov 2011 21:44:08 +0800, Lin Ming wrote:
> On Tue, Nov 29, 2011 at 9:18 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> > On Tue, Nov 29, 2011 at 2:48 AM, Lin Ming <ming.m.lin@intel.com> wrote:
> >> Yes, we should put the call back.
> >
> > Great, are you going to push this patch yourself?
> 
> Yes. I'll send it to Len.

Thanks. Please make sure it goes to stable@kernel.org too, as this
regression will cause trouble for many lm-sensors users.

-- 
Jean Delvare
