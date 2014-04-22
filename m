From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Resend Patch 6/9] I2C: Add smbus word/block process call helper
 function
Date: Tue, 22 Apr 2014 14:26:13 +0300
Message-ID: <20140422112613.GJ30677@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-7-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27907 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbaDVLSz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Apr 2014 07:18:55 -0400
Content-Disposition: inline
In-Reply-To: <1398147855-9868-7-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: wsa@the-dreams.de, rjw@rjwysocki.net, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Apr 22, 2014 at 02:24:12PM +0800, Lan Tianyu wrote:
> Add i2c_smbus_word/block_proc_call() helper function. These will be used
> in the implementation of i2c ACPI address space handler.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
