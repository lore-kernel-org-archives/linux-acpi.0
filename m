From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: HP Compaq nc6320
Date: Thu, 12 Oct 2006 16:53:02 +0200
Message-ID: <200610121653.02622.rjw@sisk.pl>
References: <1160604516.5349.14.camel@pcjc2lap> <1160610784.7763.3.camel@pcjc2lap> <1160611737.5429.4.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:2487 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932117AbWJLOwk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 10:52:40 -0400
In-Reply-To: <1160611737.5429.4.camel@pcjc2lap>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org

On Thursday, 12 October 2006 02:08, Peter Clifton wrote:
> 
> > Wierdly, I've lost the Battery/AC adapter status monitoring again, with
> > or without ec_intr=0.
> 
> > Gets odder!
> 
> Ok,
> 
> Nearing completion of this tale I think..
> 
> Turns out there is a known problem with psmouse, which leaves the
> system / ACPI / something in a bad state if psmouse is loaded before
> shutdown or reboot. Googling tells me that either removing batteries, AC
> etc.. before powering up, booting Windows, or shutting down Linux with
> psmouse removed, will "fix" the symptoms.

Do you remember any URLs?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
