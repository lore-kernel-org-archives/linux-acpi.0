From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 1/1] device properties: Fix return codes for
 __acpi_node_get_property_reference
Date: Tue, 10 Oct 2017 17:22:09 +0300
Message-ID: <20171010142209.7gctlpyurenccp7z@paasikivi.fi.intel.com>
References: <20171005060424.16780-1-sakari.ailus@linux.intel.com>
 <14664181.1rcyu63NdN@aspire.rjw.lan>
 <20171005140147.epmyxhcc7dtlam27@kekkonen.localdomain>
 <CAJZ5v0ioV4tVYg+KXdLsTca8F0OkHt-oxESj-vWOaxNnvmNdgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35257 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932134AbdJJOXN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Oct 2017 10:23:13 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ioV4tVYg+KXdLsTca8F0OkHt-oxESj-vWOaxNnvmNdgA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@intel.com>, "Yang, Hyungwoo" <hyungwoo.yang@intel.com>

On Thu, Oct 05, 2017 at 10:40:42PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 5, 2017 at 4:01 PM, Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > Hi Rafael,
> >
> > On Thu, Oct 05, 2017 at 02:59:45PM +0200, Rafael J. Wysocki wrote:
> >> On Thursday, October 5, 2017 8:04:24 AM CEST Sakari Ailus wrote:
> >> > Fix more return codes for device property: Align return codes of
> >> > __acpi_node_get_property_reference. In particular what was missed
> >> > previously:
> >> >
> >> > -EPROTO could be returned in certain cases, now -EINVAL;
> >> > -EINVAL was returned if the property was not found, now -ENOENT;
> >> > -EINVAL was returned also if the index was higher than the number of
> >> > entries in a package, now -ENOENT.
> >> >
> >> > Fixes: ("device property: Align return codes of __acpi_node_get_property_reference")
> >> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >> > Tested-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
> >> > ---
> >> > Hi Rafael,
> >> >
> >> > Unfortunately the patch I posted the previous time to remedy the issue
> >> > ("device property: Align return codes of
> >> > _acpi_node_get_property_reference") did not fully fix the issue.
> >>
> >> OK, thanks for letting me know, but why didn't it?
> >
> > My testing appears to have been more limited than I thought, Hyungwoo later
> > on found this out. (Reported-by: Hyungwoo... would be appropriate, I'll add
> > that the next time.)
> 
> Well, you're not saying what exactly still doesn't work with the
> previous patch applied which really is what I was asking about.

Hmm. The subject says it but I'll add it to the commit message as well.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
