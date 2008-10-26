From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [PATCH 1/4] Hibernate: Call platform_begin before
	swsusp_shrink_memory
Date: Sun, 26 Oct 2008 13:00:52 +0100
Message-ID: <20081026120052.GA1607@ucw.cz>
References: <200810222249.20629.rjw@sisk.pl> <200810222250.36537.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43113 "EHLO UNKNOWN"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751059AbYJZMBT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Oct 2008 08:01:19 -0400
Content-Disposition: inline
In-Reply-To: <200810222250.36537.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Wed 2008-10-22 22:50:35, Rafael J. Wysocki wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Hibernate: Call platform_begin before swsusp_shrink_memory
> 
> Call platform_begin() before swsusp_shrink_memory() so that we can
> always allocate enough memory to save the ACPI NVS region from
> platform_begin().
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
