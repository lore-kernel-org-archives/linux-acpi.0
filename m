From: Len Brown <lenb@kernel.org>
Subject: Re: sbs driver
Date: Fri, 26 Jan 2007 04:10:22 -0500
Message-ID: <200701260410.24361.lenb@kernel.org>
References: <8E389A5F2FEABA4CB1DEC35A25CB39CE7839BD@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37914 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030842AbXAZJL5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 04:11:57 -0500
In-Reply-To: <8E389A5F2FEABA4CB1DEC35A25CB39CE7839BD@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Cc: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>, linux-acpi@vger.kernel.org

On Monday 27 November 2006 21:25, Lebedev, Vladimir P wrote:
> 
> Len,
> 
> Attached patch contains new release of sbs driver.
> 
> The sbs driver was cleaned and restructured. Patch is based on
> 2.6.19-rc6-mm1. It was tested on Acer 2300 laptop. I suggest add patch
> to mm tree.

Vladimir,
Looks like we failed to merge this one.
(in general, if I don't ack or somehow respond within a week or so, re-ping.
 This one was sent the day after Thanksgiving here in the US
 and I never saw it)

Is this patch entirely clean-up, or are there any functional changes?

Sifting through the 1500 line patch it was hard to tell, but it
looked to be at least mostly cleanup, with maybe some
of the errors messages changed.

Please refresh this patch against 2.6.20-rc6
If there are any functional changes, please split them out
into a single patch per logical change and send a series
and provide check in comments describing exactly
what changed and why.

thanks,
-Len

