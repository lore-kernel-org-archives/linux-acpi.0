From: Luming Yu <luming.yu@gmail.com>
Subject: Re: PME via interrupt or SCI mechanism?
Date: Tue, 27 Sep 2011 19:21:41 +0800
Message-ID: <CAJRGBZxTakHn-BQTrLXsccriGAOERDox0pORMP+vrazzqAA-kQ@mail.gmail.com>
References: <20110912171003.GA7939@xanatos>
	<20110922183201.GA4659@xanatos>
	<201109251653.04170.rjw@sisk.pl>
	<201109270020.26439.rjw@sisk.pl>
	<20110926234835.GA9551@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53064 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab1I0LVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2011 07:21:43 -0400
In-Reply-To: <20110926234835.GA9551@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, robert.moore@intel.com, Shaohua Li <shaohua.li@intel.com>

On Tue, Sep 27, 2011 at 7:48 AM, Sarah Sharp
<sarah.a.sharp@linux.intel.com> wrote:
>
> Ok. =C2=A0Do you have suggestions for any tests I can run or debuggin=
g
> statements to add? =C2=A0I'm really not an ACPI expert and I've been
> basically fumbling in the dark.

The following patch from Shaohua might be useful to help debugging the =
problem.
http://kerneltrap.org/mailarchive/linux-usb/2009/7/30/6251245

/l
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
