From: Thomas Renninger <trenn@suse.de>
Subject: Re: Debug interface used for error message cleanups
Date: Thu, 31 Jul 2008 11:59:09 +0200
Message-ID: <200807311159.11276.trenn@suse.de>
References: <1217449342-20312-1-git-send-email-trenn@suse.de> <9D39833986E69849A2A8E74C1078B6B3BFA624@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:53174 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbYGaJ7N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 05:59:13 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3BFA624@orsmsx415.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Wednesday 30 July 2008 22:29:19 Moore, Robert wrote:
> I'm going to go ahead and remove these from ACPICA.
>
> We added an "obsolete" warning in the header file some time ago, and I
> think the time has come to remove them, especially in light of these
> patches to Linux.

Great thanks.
If you are at that, do you think it makes sense to intruduce a GPE
bit?
Just leaving it unused for now?

I didn't play with these much yet, Rui, do you think this makes sense? The 
fact there were several sever problems recently and GPEs possibly
must get debugged by people writting other device drivers who do not know
and do not want to know about the output of the other debug flags I thought 
this could make sense.

Just an idea...,

       Thomas
