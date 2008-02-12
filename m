From: Greg KH <gregkh@suse.de>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Tue, 12 Feb 2008 12:56:22 -0800
Message-ID: <20080212205622.GA21986@suse.de>
References: <200802111623.38478.elendil@planet.nl> <200802122139.14840.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:47727 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756298AbYBLVDg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Feb 2008 16:03:36 -0500
Content-Disposition: inline
In-Reply-To: <200802122139.14840.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Feb 12, 2008 at 09:39:14PM +0100, Frans Pop wrote:
> (Resending full details as I can't find my previous mail in the archives.)
> 
> On Monday 11 February 2008, Frans Pop wrote:
> > In general 2.6.25 if looking quite good on my desktop, but there's one
> > important issue: the system no longer powers off after shutdown.
> > This works fine with 2.6.24.
> 
> Don't ask me why, but bisection shows this commit to be the cause of the
> failure to power off:
> commit c10997f6575f476ff38442fa18fd4a0d80345f9d
> Author: Greg Kroah-Hartman <gregkh@suse.de>
> Date:   Thu Dec 20 08:13:05 2007 -0800
> 
>     Kobject: convert drivers/* from kobject_unregister() to kobject_put()
> 
> Because it seemed somewhat unlikely, I have double checked this by doing an
> extra compilation for this commit and its predecessor.

What is the symptom of not powering off?

Can you press SysRq-T and see a task list running and waiting when
things should be shut down?

Do you happen to have a USB storage stick plugged into the system?

thanks,

greg k-h
