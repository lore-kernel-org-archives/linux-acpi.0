From: Len Brown <lenb@kernel.org>
Subject: Re: current git breaks resume
Date: Sun, 11 Feb 2007 00:02:38 -0500
Message-ID: <200702110002.38328.lenb@kernel.org>
References: <20070209190307.GC6152@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32907 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729AbXBKFD6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Feb 2007 00:03:58 -0500
In-Reply-To: <20070209190307.GC6152@kernel.dk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Friday 09 February 2007 14:03, Jens Axboe wrote:
> Hi,
> 
> Unfortunately I'm a little short on time as I'll be travelling tomorrow,
> but of course preparing a new kernel for the laptop is something you
> want to do right before leaving. So I discovered that the current (well
> as of yesterday, HEAD is 5986a2ec35836a878350c54af4bd91b1de6abc59)
> doesn't resume on my x60. 2.6.20 works fine, so something broke since
> then.

resume from RAM, or resume from disk?

