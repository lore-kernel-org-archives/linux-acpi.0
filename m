From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] dell-wmi Switch support and Tablet switch definition
Date: Fri, 19 Jun 2009 15:02:28 +0100
Message-ID: <20090619140228.GA21354@srcf.ucam.org>
References: <1245410112-13659-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54614 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbZFSOC1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 10:02:27 -0400
Content-Disposition: inline
In-Reply-To: <1245410112-13659-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-acpi@vger.kernel.org

On Fri, Jun 19, 2009 at 07:15:12AM -0400, Rafi Rubin wrote:
> Added a bit of missing code needed to handle switch events.
> 
> Added the definitions for the hinge rotation as seen on the
> Latitude XT tablet.

Having thought about this a bit more, I think there's a pretty 
fundamental problem right now - we don't know whether we're in tablet 
mode or not when we boot, so can't set the initial state. Software that 
depends on that may be rather confused as a result...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
