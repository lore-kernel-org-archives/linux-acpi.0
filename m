From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: no self-refresh during S3 - any debug hints?
Date: Thu, 19 Jun 2008 16:09:47 +0100
Message-ID: <20080619150947.GA19908@srcf.ucam.org>
References: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34248 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbYFSPJ4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jun 2008 11:09:56 -0400
Content-Disposition: inline
In-Reply-To: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Trull <linmodemstudent@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, May 31, 2008 at 12:15:50PM -0700, Jeff Trull wrote:

> I'm running kernel 2.6.20 on a laptop with an ATI IGP 320M Northbridge
> and an Athlon XP.  DSDT has a _PTS but no _GTS.  I'm comfortable
> recompiling the kernel.  Any suggestions as to how to proceed,
> experiments to run, etc.?

Hi Jeff,

Could you attach the output of lspci -vxxx -s 0:0.0 ? Needs to be run as 
root.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
