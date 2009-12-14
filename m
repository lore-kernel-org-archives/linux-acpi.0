From: "Youquan,Song" <youquan.song@linux.intel.com>
Subject: Re: [PATCH]acpi c-states: Fix ACPI C3 is wrongly mapped to C2
Date: Mon, 14 Dec 2009 08:12:55 -0500
Message-ID: <20091214131255.GA4126@youquan-linux.bj.intel.com>
References: <20091212181442.GA22832@youquan-linux.bj.intel.com> <20091212142727.GA6867@comet.dominikbrodowski.net> <20091212235549.GA7753@youquan-linux.bj.intel.com> <20091213084317.GA15989@isilmar.linta.de> <20091214100200.GA17243@youquan-linux.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:11753 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750878AbZLNFh0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2009 00:37:26 -0500
Content-Disposition: inline
In-Reply-To: <20091214100200.GA17243@youquan-linux.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, lenb@kernel.org, venkatesh.pallipadi@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org

> > Yes, but what happens if there are two states of type C2? The whole concept
> > of "type C<number>" and "state C<number>" was broken from the beginning...
> 
> Sorry. In my mind, there is no two states of ACPI C2. If processor C3
> above are mapped to ACPI C3, so processor C1 is mapped to ACPI C1,
> processor C2 is mapped to ACPI C2.  
> Len Brown, Am I right?
> 
> If I am wrong, I will file another patches for it.  

This patch handle the ACPI C2 invlidation on some platform.
Another patch "acpi c-states: Fix multiply C-states name
disturbance" will unify multiply C-states name.

-Youquan  
