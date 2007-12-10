From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: suspend to RAM failure on t61p
Date: Sun, 9 Dec 2007 16:40:53 -0800
Message-ID: <20071209164053.fc8ceabb.akpm@linux-foundation.org>
References: <20071209011928.c9873c66.akpm@linux-foundation.org>
	<475BE227.2040003@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43983 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751136AbXLJAk6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Dec 2007 19:40:58 -0500
In-Reply-To: <475BE227.2040003@dbservice.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
Cc: linux-acpi@vger.kernel.org

On Sun, 09 Dec 2007 13:40:07 +0100 Tomas Carnecky <tom@dbservice.com> wrote:

> Andrew Morton wrote:
> > 2.6.24-rc4 on a Lenovo t61p, using FC8 config.
> > 
> > echo mem > /sys/power/state while running X.
> > 
> > It appears to suspend OK but then it instantly resumes and runs
> > OK except the display is blank.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=9258
> 
> I have a X61 tablet, and the screen is blank after resume, too, but
> pressing ctrl+alt+F1/F7 usually fixes it. It seems a problem with the X
> video driver. I'm not sure though.
> 

This machine doesn't bring the display back after resume-from-RAM under
2.6.23 either.

The post-2.6.23 regresison here is that the suspend itself fails.  Under
2.6.23 the machine suspends and requires a keystrike to start resuming. 
Under 2.6.24-rc4 it just instantly resumes all by itself.

And I'm having real problems working out why 2.6.23 and 2.6.24-rc4 work
OK(ish) but anything in between won't boot: can't open /dev/root. 
Everything has scrolled off, no serial, no netconsole..  
