From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Add support for Eject hotkey in dell-wmi
Date: Mon, 20 Apr 2009 19:28:48 +0100
Message-ID: <20090420182848.GA3105@srcf.ucam.org>
References: <49ECBAE2.2080308@dell.com> <20090420182312.GA2910@srcf.ucam.org> <49ECBE35.9040003@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37660 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbZDTS2w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Apr 2009 14:28:52 -0400
Content-Disposition: inline
In-Reply-To: <49ECBE35.9040003@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 20, 2009 at 01:25:57PM -0500, Mario Limonciello wrote:
> Hi Matthew:
> Matthew Garrett wrote:
> > On Mon, Apr 20, 2009 at 01:11:46PM -0500, Mario Limonciello wrote:
> >   
> >
> > Looks good - can you confirm that it'll be removed from the normal 
> > keyboard interface at the same time?
> >   
> No it won't be removed at the same time on all machines during the
> transition period.  I've however requested to add a BIOS option for the
> machines that support this to try to enable or disable WMI support in
> the interim.

Ok. How can we determine whether we're on a machine with this support? 
Applying this patch right now will result in systems receiving the event 
twice.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
