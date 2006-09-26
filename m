From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [ltp] [Patch 0/3] ibm-acpi: Remove experimental flag from brightness and volume. Update documentation
Date: Tue, 26 Sep 2006 19:42:10 +0200
Message-ID: <20060926174210.GA28390@susi>
References: <20060922101913.276298370@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sirius.lasnet.de ([62.75.240.18]:31874 "EHLO sirius.lasnet.de")
	by vger.kernel.org with ESMTP id S932212AbWIZRxd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 13:53:33 -0400
Content-Disposition: inline
In-Reply-To: <20060922101913.276298370@datenfreihafen.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: borislav@users.sf.net, linux-acpi@vger.kernel.org, jeremy@goop.org, multinymous@gmail.com, hmh@hmh.eng.br, linux-thinkpad@linux-thinkpad.org

Hello Len.

On Fri, 2006-09-22 at 12:19, Stefan Schmidt wrote:
> 
> Since version 0.11 ecdump, brightness, volume and fan a available in
> ibm-acpi, but only if you set experimental=1 on loading.
> 
> You released this version at 2005-03-17. So this is quit some time to
> see if some of these features make problems.
> 
> I think it's ok to make ecdump and fan only available, if loaded with
> experimental. As ecdump is only for debugging and explore new features
> and fan stop can damage the hardware.
> 
> Both features were tested with various scripts and application for a long 
> time without problems.
> 
> Second patch updates the documentation for the first patch.
> 
> Third one documents the new wan feature from Jeremy Fitzhardinge. Please review
> this, as I don't have a device to test this.

Any comments about this patches?

The first try of the first patch I sent to Borislav at 2006-08-24,
only linux-thinkpad cc'ed this time:

http://marc.theaimsgroup.com/?l=linux-thinkpad&m=115643103426795&w=2

Unfortunately it is not the first time Borislav don't reply on
patches. What's the way to go here?

regards
Stefan Schmidt
