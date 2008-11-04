From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 4/7] [sony-laptop] detect the ICH9 chipset as Type3
Date: Tue, 4 Nov 2008 22:21:34 +0900
Message-ID: <20081104132133.GA22606@inferi.kami.home>
References: <1225705280-12775-1-git-send-email-malattia@linux.it> <1225705280-12775-2-git-send-email-malattia@linux.it> <1225705280-12775-3-git-send-email-malattia@linux.it> <1225705280-12775-4-git-send-email-malattia@linux.it> <1225705280-12775-5-git-send-email-malattia@linux.it> <20081104082217.93FA5E0D3@master.hanzubon.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:44001
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753097AbYKDNVi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Nov 2008 08:21:38 -0500
Content-Disposition: inline
In-Reply-To: <20081104082217.93FA5E0D3@master.hanzubon.jp>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Tue, Nov 04, 2008 at 05:22:17PM +0900, ISHIKAWA Mutsumi wrote:
> >>>>> In <1225705280-12775-5-git-send-email-malattia@linux.it> 
> >>>>>	Mattia Dongili <malattia@linux.it> wrote:
> >> From: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>
> >>
> >> Signed-off-by: Mattia Dongili <malattia@linux.it>
> >> ---
> >>  drivers/misc/sony-laptop.c |    7 +++++++
> >>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> >> diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
> >> index c9e5651..19f3306 100644
> >> --- a/drivers/misc/sony-laptop.c
> >> +++ b/drivers/misc/sony-laptop.c
> >> @@ -1589,6 +1589,13 @@ static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
> >>  		goto out;
> >>  	}
>  
> >> +	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
> >> +			PCI_DEVICE_ID_INTEL_ICH9_1, NULL);
> >> +	if (pcidev) {
> >> +		dev->control = &spic_types[4];
> 
>  In patch [PATCH 1/7] [sony-laptop] merge Type4 into Type3,
> type 3 and type 4 spic models are merged, and type 5 model
> I added (of cause It is not problem, it is completly same as
> type 4) are dropped.
> 
>  So I think spic_types[4] is invalid. This line should be as
> bellow (Use Type 3 on ICH9_1 machines):
> 
>   dev->control = &spic_types[2];

gosh!
/me looks for his emergency brown paperbag

Len,
I'll resend the patchset in the next days, I'll also see if I can rework
the rfkill one to use the proper subsystem.

thanks
-- 
mattia
:wq!
