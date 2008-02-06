From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/5] WMI patches for acpi-test (v2)
Date: Tue, 5 Feb 2008 17:35:54 -0700
Message-ID: <200802051735.55106.bjorn.helgaas@hp.com>
References: <20080205021658.4422.83165.stgit@pacifica> <200802051603.30466.lenb@kernel.org> <200802052118.02733.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <200802052118.02733.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-ia64-owner@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 05 February 2008 02:18:01 pm Carlos Corbacho wrote:
> On Tuesday 05 February 2008 21:03:30 Len Brown wrote:
> > On Monday 04 February 2008 21:16, Carlos Corbacho wrote:
> > > 2) Do you know of any IA64 systems using ACPI-WMI? At the moment, WMI
> > > will work on x86 and hopefully IA64, but if it turns out that no vendor
> > > has or ever will implement ACPI-WMI on IA64, then we could safely drop it
> > > there.
> >
> > I recommend skipping WMI on IA64 unless/until a real need to support it
> > emerges. There are no WMI extensions on the Intel Tiger or Hitachi Fusion
> > IA64 boxes I have access to.
> 
> Ok. The only other vendors I really have in mind are HP and Fujitsu, since 
> both those vendors use WMI on their laptops, so they would be my most likely 
> candidates to have WMI on an IA64 box (if anyone actually does use WMI on 
> IA64).

How could I tell whether our HP systems use WMI?

Bjorn
