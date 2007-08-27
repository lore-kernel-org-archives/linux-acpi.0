From: Dave Jones <davej@redhat.com>
Subject: Re: [Bug 8243] Problem with Throttling and CPU power state
Date: Mon, 27 Aug 2007 16:19:12 -0400
Message-ID: <20070827201912.GA7452@redhat.com>
References: <bug-8243-27@http.bugzilla.kernel.org/> <20070827194633.44C5010807D@picon.linux-foundation.org> <20070827130146.e43127dd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52709 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758835AbXH0UTS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2007 16:19:18 -0400
Content-Disposition: inline
In-Reply-To: <20070827130146.e43127dd.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

On Mon, Aug 27, 2007 at 01:01:46PM -0700, Andrew Morton wrote:
 > On Mon, 27 Aug 2007 12:46:33 -0700 (PDT)
 > bugme-daemon@bugzilla.kernel.org wrote:
 > 
 > > http://bugzilla.kernel.org/show_bug.cgi?id=8243
 > 
 > This is presently assigned to cpufreq@www.linux.org.uk.  Should it
 > be assigned to acpi instead?

Yes. cpufreq does nothing with c states.

	Dave

-- 
http://www.codemonkey.org.uk
