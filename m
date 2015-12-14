From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH v4 0/6] nvdimm: Add an IOCTL pass thru for DSM calls
Date: Mon, 14 Dec 2015 10:33:07 -0700
Message-ID: <20151214173307.GA47566@tevye.fc.hp.com>
References: <cover.1450036445.git.jerry.hoemann@hpe.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55]:58551 "EHLO
	g1t5425.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbbLNRdM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2015 12:33:12 -0500
Content-Disposition: inline
In-Reply-To: <cover.1450036445.git.jerry.hoemann@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, elliott@hpe.com, jmoyer@redhat.com, krivenok.dmitry@gmail.com, linda.knippers@hpe.com
Cc: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Dec 13, 2015 at 06:54:21PM -0700, Jerry Hoemann wrote:
> 
> The NVDIMM code in the kernel supports an IOCTL interface to user
> space based upon the Intel Example DSM:
> 
> 	http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
> 
> This interface cannot be used by other NVDIMM DSMs that support
> incompatible functions.
> 
> This patch set adds a generic "passthru" IOCTL interface which
> is not tied to a particular DSM.
> 

  ...


> 
> Changes in version 4:
> ---------------------

...


Sorry, forgot to update version number in the email title. 

This is version 4 of this patch series.



-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
