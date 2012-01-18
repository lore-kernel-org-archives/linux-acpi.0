From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: APEI: Can not request iomem region for GARs
Date: Wed, 18 Jan 2012 10:03:30 -0700
Message-ID: <CAErSpo6UThP57zoHheYZahqMKGbopnTYQNL6ZSbS=H9Yf5yDdQ@mail.gmail.com>
References: <fa.VBW83nzmCUJkL7i8PnQCE+XJLbw@ifi.uio.no> <fa.tJPpWxTvpszc3I1v45J3M2ECj9E@ifi.uio.no>
 <fa.tL8DWu2lMG0ACwU85eZnSJgwW4c@ifi.uio.no> <fa.ND4Vxr1bDKbI4wO4Neh3v3LnNi8@ifi.uio.no>
 <fa.ujRlmAar6Re/yHHbpRR2c1B+waM@ifi.uio.no> <fa.Wg29YXcB/Uo8sZJfJS4lt54jnMc@ifi.uio.no>
 <3229730.1980.1326903611960.JavaMail.geo-discussion-forums@prog27>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52389 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932196Ab2ARRDw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2012 12:03:52 -0500
Received: by lahc1 with SMTP id c1so2345775lah.19
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2012 09:03:51 -0800 (PST)
In-Reply-To: <3229730.1980.1326903611960.JavaMail.geo-discussion-forums@prog27>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fa.linux.kernel@googlegroups.com
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, lucas.gary@gmail.com, Huang Ying <ying.huang@intel.com>

On Wed, Jan 18, 2012 at 9:20 AM,  <lucas.gary@gmail.com> wrote:
> I've just ran a preupgrade on my box (Supermicro 7046A) and I'm now getting this on boot:
>
> Loading Linux 3.1.9-1.fc16.x86_64 ...
> Loading initial ramdisk ...
> [2.135273] APEI: Can not request iomem region region <00000000bf795eba-00000000bf795ebc> for GARS
>
> It always ran this message but now on reboot it's halting at the message.

I'd be surprised if we actually halted right at that message.  I think
it's just that most console output is suppressed by default, this
particular message is KERN_ERR so it is not suppressed, and we hung
somewhere later.  Can you boot with "ignore_loglevel" and collect the
entire console output?  If you have a previous working kernel still
installed, a corresponding log from it might also be useful.

Bjorn
