From: Dave Jones <davej@redhat.com>
Subject: Re: latest ACPI patch vs 2.6.17-rc4
Date: Fri, 12 May 2006 09:54:29 -0400
Message-ID: <20060512135429.GB3410@redhat.com>
References: <200605120518.38033.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:65511 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932078AbWELNyc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 May 2006 09:54:32 -0400
Content-Disposition: inline
In-Reply-To: <200605120518.38033.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Fri, May 12, 2006 at 05:18:37AM -0400, Len Brown wrote:
 > Folks,
 > The latest ACPI patch is against 2.6.17-rc4 and is available here:
 > 
 > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
 > ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.17/acpi-test-20060310-2.6.17-rc4.diff.gz
 > 
 > Note that I removed the acpi_in_resume workaround, so you'll get some oops'
 >  during resume, until we replace it with something else.

Which you intend to do before .17 final I assume?
Seems funny to be ripping something out without a replacement fix.

		Dave

-- 
http://www.codemonkey.org.uk
