From: Thomas Christensen <christensenthomas@gmail.com>
Subject: Re: [Aspire V5-431] Brightness control visible but does nothing
Date: Fri, 17 Jan 2014 09:13:41 +0700
Message-ID: <20140117021341.GA22022@3bb.co.th>
References: <CADNMoF1A2iExRav_O8GYm8P9jbaf2GqPRsi+eymNtcddyfnUfA@mail.gmail.com>
 <52D60057.2050505@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:44170 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbaAQCNr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jan 2014 21:13:47 -0500
Received: by mail-pb0-f48.google.com with SMTP id rr13so3453250pbb.7
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jan 2014 18:13:46 -0800 (PST)
Received: from thomasc-Aspire-V5-431 ([183.89.70.8])
        by mx.google.com with ESMTPSA id nw11sm24700077pab.13.2014.01.16.18.13.44
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 16 Jan 2014 18:13:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52D60057.2050505@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Wed, Jan 15, 2014 at 11:28:23AM +0800, Aaron Lu wrote:
> On 01/14/2014 06:02 PM, Thomas Christensen wrote:
> > This laptop gets a /sys/class/backlight/acpi_video0 entry for
> > backlight that is not working.
> > 
> > $ ls /sys/class/backlight
> > acpi_video0  intel_backlight
> > 
> > and I see the following entry in the kernel log:
> > 
> > [   19.515016] acer_wmi: Brightness must be controlled by acpi video driver
> > 
> > By using 'acpi_backlight=vendor' my desktop starts to work.
> 
> Please file a bug to kernel bugzilla:
> https://bugzilla.kernel.org/
> Choose ACPI/Power-Video, and attach your acpidump there.

opened as

https://bugzilla.kernel.org/show_bug.cgi?id=68751

let me know if I can be of further assistance.

Thanks,
Thomas
