From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH 3/4] nvdimm: Add IOCTL pass thru
Date: Thu, 12 Nov 2015 08:33:42 -0700
Message-ID: <20151112153342.GA129240@tevye.fc.hp.com>
References: <CAJN_NGaPbziX=OcyYpcn5TP76HwGQSTsUz-yOVGB2Sh8VxDQjA@mail.gmail.com>
 <20151109215904.GB33245@tevye.fc.hp.com>
 <CAJN_NGY0Zop4=_NrW8Y3md7Up9FRq9voQ2UYiTPgXCv9XP8u5A@mail.gmail.com>
 <20151111214435.GB95024@tevye.fc.hp.com>
 <CAJN_NGZufvD=GLkw2sscCOEdY9JB0ADSQzggrnEeeEGtdZkiOQ@mail.gmail.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2352.austin.hp.com ([15.217.128.51]:37701 "EHLO
	g2t2352.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbbKLPdq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2015 10:33:46 -0500
Content-Disposition: inline
In-Reply-To: <CAJN_NGZufvD=GLkw2sscCOEdY9JB0ADSQzggrnEeeEGtdZkiOQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Krivenok <krivenok.dmitry@gmail.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org

On Thu, Nov 12, 2015 at 12:52:47AM +0300, Dmitry Krivenok wrote:
> > but, we still want to go through entire list.
> 
> Shouldn't you break the loop immediately after you found the bus and sent ioctl?
> Maybe I'm missing something, but I see no reason to continue iterating
> after the bus was found (even though you don't do anything and just
> compare IDs and "continue").

okay, i understand now what you're saying.  i'll address in version 2.

-- 

-----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer      Hewlett-Packard Enterprise
-----------------------------------------------------------------------------
