From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpi: update struct acpi_table_tpm2
Date: Tue, 9 Jun 2015 16:12:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F2C83@ORSMSX112.amr.corp.intel.com>
References: <1433770706-3332-1-git-send-email-jarkko.sakkinen@linux.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F28EC@ORSMSX112.amr.corp.intel.com>
 <20150609091757.GB4968@jsakkine-mobl1>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F2BE7@ORSMSX112.amr.corp.intel.com>
 <20150609151919.GA4453@jsakkine-mobl1> <20150609154230.GA5750@jsakkine-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150609154230.GA5750@jsakkine-mobl1>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "open list:ACPI COMPONENT AR..." <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT AR..." <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Well, you don't have to use it. ACPICA has done this in several other places. Anyway, I'm hesitant to just remove it at this point.


> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Tuesday, June 09, 2015 8:43 AM
> To: Moore, Robert
> Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; open list:ACPI COMPONENT
> AR...; open list:ACPI COMPONENT AR...; open list
> Subject: Re: [PATCH] acpi: update struct acpi_table_tpm2
> 
> On Tue, Jun 09, 2015 at 06:19:19PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Jun 09, 2015 at 02:21:12PM +0000, Moore, Robert wrote:
> > > ACPICA usually defines any "related" data structures, just for user
> > > convenience.
> >
> > If you want to keep it, it's fine for me but we still probably use the
> > internal structure for it in tpm_crb driver (as tpm_tis uses internal
> > structure for CRB).
> 
> Let me open this a little bit. Everytime we want to do some small change
> to control area (lets say TCG adds some flag) we would have to cycle them
> through you.
> 
> And the changes are not coupled with ACPI in any possible way. This is
> only adds more maintenance burden to you and also to us. This structure is
> the main control structure for the CRB driver and will be refined many
> times in the future. There is no any kind of use to its fields outside of
> the CRB driver.
> 
> /Jarkko
