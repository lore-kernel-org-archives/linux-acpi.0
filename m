From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Thu, 17 Feb 2005 11:00:21 +0000
Message-ID: <1108638021.4085.143.camel@tyrosine>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <1108621005.2096.412.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108621005.2096.412.camel@d845pe>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@suse.cz>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-02-17 at 01:16 -0500, Len Brown wrote:
> Pavel,
> I think that it is the BIOS' job on S3-suspend
> to save the video mode.  On S3-resume the BIOS should
> re-POST and restore the video mode.

I agree, but in the absence of spec requirement and some form of
certification process, I don't see it happening in the near future.
Given that vendors are still shipping invalid DSDTs, if Windows is able
to reinitialise the graphics hardware, few are going to care about
making life easier for Linux.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
