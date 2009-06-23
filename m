From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: why do drivers evaluate _INI?
Date: Tue, 23 Jun 2009 09:01:38 -0600
Message-ID: <200906230901.38855.bjorn.helgaas@hp.com>
References: <200906221732.35993.bjorn.helgaas@hp.com> <71cd59b00906230153q38f2d9b5h6c57621c389ecb0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:40748 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760210AbZFWPCZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2009 11:02:25 -0400
In-Reply-To: <71cd59b00906230153q38f2d9b5h6c57621c389ecb0f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@suse.cz>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

On Tuesday 23 June 2009 2:53:07 am Corentin Chary wrote:
> I don't know if it's related, but:
> eeepc-laptop is calling "INIT" for device ASUS010
> asus-laptop is calling "INIT" for device ATK0100
> 
> But for eeepc-laptop we provide some flags special to INIT, and in
> asus-laptop it returns the model name.
> So I don't think we can move INIT for these.

Thanks for looking into this.  The "INIT" methods are something
completely different -- they are device-specific things, so it's
fine for them to be in the driver.  The "_INI" method, like others
named with a leading underscore, is defined by the ACPI spec.
Drivers do even use some of these spec-defined methods, but in
the case of "_INI", I think it makes more sense to take care of
it in the ACPI CA or the Linux/ACPI core.

Bjorn
