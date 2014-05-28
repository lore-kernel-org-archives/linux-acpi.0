From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: new trace output format
Date: Tue, 27 May 2014 23:32:17 -0400
Message-ID: <1401247938-22125-1-git-send-email-gong.chen@linux.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52012 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbaE1D74 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 May 2014 23:59:56 -0400
In-Reply-To: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

Hi, Boris

Here is the new output format:

          <idle>-0     [000] d.h.   242.340120: extlog_mem_event: 1 corrected error: unknown DIMM location: Memriser1 CHANNEL A DIMM 0 physical addr: 0000000441a07000 (mask lsb: ff), node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 32336 column: 1056 FRU: 00000000-0000-0000-0000-000000000000
          <idle>-0     [000] d.h.   349.380406: extlog_mem_event: 2 corrected error: unknown DIMM location: Memriser1 CHANNEL A DIMM 0 physical addr: 00000004416ae000 (mask lsb: ff), node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 31802 column: 1064 FRU: 00000000-0000-0000-0000-000000000000

I add extra "physical addr:" as prefix. If you don't like it, please feel free to remove it.
