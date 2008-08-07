From: Karel Zak <kzak@redhat.com>
Subject: Re: 2.6.27-rc1: critical thermal shutdown on thinkpad x60
Date: Thu, 7 Aug 2008 13:34:00 +0200
Message-ID: <20080807113400.GA18297@nb.net.home>
References: <20080806090246.GA1572@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:55163 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298AbYHGMtc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Aug 2008 08:49:32 -0400
Content-Disposition: inline
In-Reply-To: <20080806090246.GA1572@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Wed, Aug 06, 2008 at 11:02:47AM +0200, Pavel Machek wrote:
> Hi!
> 
> Aug  6 11:00:10 amd kernel: ACPI: Critical trip point
> Aug  6 11:00:10 amd kernel: Critical temperature reached (128 C),
> shutting down.
> Aug  6 11:00:10 amd shutdown[24414]: shutting down for system halt
> 
> ...and machine went down at that point :-(.

 It seems it like a bad day for ThinkPads:

Aug  6 20:05:36 nb kernel: ACPI: Critical trip point
Aug  6 20:05:36 nb kernel: Critical temperature reached (128 C),
shutting down.

 Kernel 2.6.26-136.fc10.x86_64 on x61.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
