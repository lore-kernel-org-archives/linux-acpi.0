From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: Laptop fan on Acer 4061NWLCi
Date: Mon, 3 Apr 2006 15:41:38 +0200
Message-ID: <20060403134138.GA13970@poupinou.org>
References: <794f042d0604030408k3073a44dg70255e3342f4a2db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:35871 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1750866AbWDCNlm
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Apr 2006 09:41:42 -0400
Content-Disposition: inline
In-Reply-To: <794f042d0604030408k3073a44dg70255e3342f4a2db@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Saurabh Nanda <saurabhnanda@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Apr 03, 2006 at 04:38:06PM +0530, Saurabh Nanda wrote:
> Hi,
> 
> I have recently bought an Acer 4061NWLCi laptop and am having trouble
> getting ACPI to work. I hope somoene will help me out :-)
> 
> I am running Ubuntu Linux -- Breezy Badger 5.10. With the default
> Ubuntu kernel (2.6.12) ACPI did not work at all. I did not even get
> the battery status in GNOME. Then I installed the latest kernel (
> 2.6.16.1) and ACPI started working - at least partially! I could check
> my CPU temperature, AC adapter status, and battery status.
> 
> The only thing not working is the CPU fan. I tried reading through my
> current(broken) DSDT and surprisingly there is no mention of a fan
> anywhere! In the Thermal Zone configuration there is no mention of
> _ACx (_AC0, _AC1, etc.) as well. I can post my DSDT to the list if it
> would help.
> 
> Can anyone please help me in fixing this? Running my laptop without a
> fan is pretty dangerous as the CPU temperatures crosses 65 degrees
> celcius at times.
> 
> Can I declare a fan and an active cooling temperature point in the
> DSDT, recompile it and hope that it would work? Has anyone else done
> this kind of a thing before?

Yes, only problem is to define _ON and _OFF methods in order to control
the fan device.  Good luck...

With my own laptop (Acer TM 4102WLMi) I can only get the fan speed,
but that's all.  I think it's possible to write some
different thresholds in order to control the cpu fan, but I don't
see why this is needed (after all 65 degree celcius should be ok for
a pentium-m).  In the case of my Acer, the fan speed is available
at 0x5d, 0x5c on the EC space and I think there are some more Acer
models that define those.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
