From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded
 Binary WMI MOF metadata
Date: Tue, 6 Jun 2017 10:02:01 -0700
Message-ID: <20170606170201.GC32509@fury>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
 <20170606100440.GA4690@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170606100440.GA4690@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 06, 2017 at 12:04:40PM +0200, Pali Rohár wrote:
> On Monday 05 June 2017 20:16:44 Andy Lutomirski wrote:
> > +#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
> > +MODULE_ALIAS("wmi:" WMI_BMOF_GUID);
> 
> Cannot we generate MODULE_ALIAS from module_wmi_driver()? IIRC it is
> working for i2c drivers.

I could see this being automated since we always use wmi:GUID, but it isn't
currently. Happy to consider it as a follow on.

Do you have a specific i2c example you think we should consider following?

-- 
Darren Hart
VMware Open Source Technology Center
