From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Sat, 12 Jan 2008 12:17:14 +0000
Message-ID: <20080112121714.GB15173@srcf.ucam.org>
References: <fmaaj5$jsl$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:57219 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbYALMRV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jan 2008 07:17:21 -0500
Content-Disposition: inline
In-Reply-To: <fmaaj5$jsl$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: giggz <giggzounet@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, Jan 12, 2008 at 01:06:30PM +0100, giggz wrote:

> I want to associate a script (which works fine) to a key (Fn+F3). This
> key is for the video output switching and my script is a video output
> switch using xrandr.
> But when I try to associate Fn+F3 it doesn't work. I have try with the
> xen command to catch the keycode, but nothing happends when I press on
> the key. All the others Fn+F* works fine (help, hibernate, luminosity,
> sound...).
> So I want to report a bug, but I don't know if it is an acpi problem or
> a xorg problem... If anyone could help me...?

Does pressing the key generate any output in dmesg? If so, you need to 
run the setkeycodes command to bind it to a keycode. If not, make sure 
you have the acpi video module loaded, do 

echo -n 4 >/proc/acpi/video/foo/DOS

and check whether it generates an acpi event (there'll be a log message 
in /var/log/acpid.log). If so, sufficiently recent kernels ought to 
generate an input event.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
