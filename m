From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Mon, 5 Feb 2007 14:49:10 -0500
Message-ID: <d120d5000702051149n2f713859na46b8c1b2398e17d@mail.gmail.com>
References: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp>
	 <3877989d0701232019g45af8feaxabdcf6ba77170a5d@mail.gmail.com>
	 <200701232138.54758.bjorn.helgaas@hp.com>
	 <200701240954.32742.bjorn.helgaas@hp.com>
	 <1170701940.25027.422.camel@d36.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:30472 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933424AbXBETtR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2007 14:49:17 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2232907nfa
        for <linux-acpi@vger.kernel.org>; Mon, 05 Feb 2007 11:49:10 -0800 (PST)
In-Reply-To: <1170701940.25027.422.camel@d36.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Luming Yu <luming.yu@gmail.com>, emisca <emisca.ml@gmail.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Pieter De Wit <Pieter.DeWit@vodacom.co.za>, linux-acpi@vger.kernel.org

Hi,

On 2/5/07, Thomas Renninger <trenn@suse.de> wrote:
> I have a patch that should fix the psmouse unload thing (at the end).
> Not sure whether it's still needed in 2.6.20-rcX, there was some work
> done... it definitely helps on 2.6.18 and 2.6.16 kernels.
> Ok, I quickly tried on 2.6.20-rc7 and it seems to work without the
> patch.

Just a limited number of boxes seems to have problems...

> Maybe Dmitry can comment on that and push this one if still needed?

I do not like the idea of removing port at shutdown. I will look into
extending psmouse_cleanup so it leaves the port in the same state as
psmouse_disconnect.

-- 
Dmitry
