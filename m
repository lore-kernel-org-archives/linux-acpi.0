From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 02/14] ACPI: Atlas ACPI driver
Date: Fri, 18 Aug 2006 10:44:54 -0400
Message-ID: <200608181044.55097.len.brown@intel.com>
References: <200608150537.k7F5bMHZ011530@shell0.pdx.osdl.net> <200608152313.56558.len.brown@intel.com> <756b48450608170048n4d4941c2s349f44883628df9a@mail.gmail.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:494 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030437AbWHROn1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 10:43:27 -0400
In-Reply-To: <756b48450608170048n4d4941c2s349f44883628df9a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaya Kumar <jayakumar.acpi@gmail.com>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, dtor_core@ameritech.net, luming.yu@intel.com

On Thursday 17 August 2006 03:48, Jaya Kumar wrote:
> On 8/16/06, Len Brown <len.brown@intel.com> wrote:
> > Andrew,
> > Please delete this patch from MM -- it is stale.
> > Jaya, please send Andrew the newer patch that replaces it -- the one
> > that doesn't touch drivers/acpi.
> >
> > thanks,
> > -Len
> 
> Hi Len,
> 
> I had sent that on June 26 to everyone on the CC list. Archive link is here:
> http://marc.theaimsgroup.com/?l=linux-acpi&m=115391161115058&w=2

that patch was an incremental depending on the previous patch.
Please send just the final patch vs 2.6.18-rc4  to the above, also cc: linux-kernel@vger.kernel.org

> Also, Dmitry had asked what we should do about handing ACPI errors to
> upper layers here:
> http://marc.theaimsgroup.com/?l=linux-acpi&m=115392091425952&w=2

Dmitry has a good question and we need to iron it out for the general case.
I recommend that for your driver you simply do something like this for now:

if (ACPI_ERROR(status))
	status = -EINVAL

and get your driver into the mm tree to find the next problem.

thanks,
-Len
