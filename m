From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 4/5] ACPI, APEI, EINJ support
Date: Wed, 06 Jan 2010 15:16:26 +0800
Message-ID: <1262762186.17852.7.camel@yhuang-dev.sh.intel.com>
References: <1261980744-4450-1-git-send-email-ying.huang@intel.com>
	 <1261980744-4450-2-git-send-email-ying.huang@intel.com>
	 <1261980744-4450-3-git-send-email-ying.huang@intel.com>
	 <1261980744-4450-4-git-send-email-ying.huang@intel.com>
	 <1261980744-4450-5-git-send-email-ying.huang@intel.com>
	 <20100106070807.GA1494@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932096Ab0AFHQg@vger.kernel.org>
In-Reply-To: <20100106070807.GA1494@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi, Pavel,

On Wed, 2010-01-06 at 15:08 +0800, Pavel Machek wrote:
> On Mon 2009-12-28 14:12:23, Huang Ying wrote:
> > EINJ provides a hardware error injection mechanism, this is useful for
> > debugging and testing of other APEI and RAS features.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > ---
> >  drivers/acpi/apei/Kconfig  |    7 +
> >  drivers/acpi/apei/Makefile |    1 +
> >  drivers/acpi/apei/einj.c   |  471 ++++++++++++++++++++++++++++++++++++++++++++
> 
> 
> Can we get more meaningfull name? err_inject.c?

einj is the abbreviation used in ACPI specification. I think following
specification can avoid some confusion. Do you think so?

Best Regards,
Huang Ying
