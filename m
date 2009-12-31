From: Huang Ying <ying.huang@intel.com>
Subject: Re: git-apply --whitespace (Re: [PATCH 2/5] ACPI, APEI, APEI
 supporting infrastructure)
Date: Thu, 31 Dec 2009 09:19:29 +0800
Message-ID: <1262222369.31401.1.camel@yhuang-dev.sh.intel.com>
References: <1261980744-4450-1-git-send-email-ying.huang@intel.com>
	 <1261980744-4450-2-git-send-email-ying.huang@intel.com>
	 <1261980744-4450-3-git-send-email-ying.huang@intel.com>
	 <alpine.LFD.2.00.0912302006520.17125@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752859AbZLaBTi@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0912302006520.17125@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "ak@linux.intel.com" <ak@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2009-12-31 at 09:14 +0800, Len Brown wrote:
> > diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> > new file mode 100644
> > index 0000000..4085bdd
> > --- /dev/null
> > +++ b/drivers/acpi/apei/Kconfig
> > @@ -0,0 +1,9 @@
> > +config ACPI_APEI
> > +	tristate "ACPI Platform Error Interface (APEI)"
> > +	depends on X86
> > +	help
> > +	  APEI allows to report errors (for example from the chipset)
> > +	  to the operating system. This improves NMI handling
> > +	  especially. In addition it supports error serialization and
> > +	  error injection.
> > +
> > diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
> 
> FYI, git apply considers a trailing blank line,
> such as the one at the end of the hunk above,
> to be a "whitespace error".
> 
> I use --whitespace=strip, which causes git to delete it
> upon checkin.  However, that causes the 4th patch in
> this series, which appents to this file, to not apply.
> 
> Please don't send patches with trailing blank lines.
> In this case, the blank should come as a "preceeding"
> blank line in the 4th patch...

Sorry about that. I will be more careful in next time.

Best Regards,
Huang Ying
