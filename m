From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V4 1/8] usb: convert port_owners type from void * to
 struct dev_state *
Date: Thu, 28 Jun 2012 10:06:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206281005290.1752-100000@iolanthe.rowland.org>
References: <1340868702-1894-2-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50122 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751322Ab2F1OGX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2012 10:06:23 -0400
In-Reply-To: <1340868702-1894-2-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Thu, 28 Jun 2012, Lan Tianyu wrote:

> This patch is to convert ort_owners type from void * to struct dev_state *

s/ort/port/

> in order to make code more readable.

Otherwise this patch is okay.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

