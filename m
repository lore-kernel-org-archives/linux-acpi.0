From: joeyli <jlee@suse.com>
Subject: Re: [RFC PATCH v3] acpi: indicate to platform when hot remove
 returns busy
Date: Mon, 3 Jul 2017 17:34:52 +0800
Message-ID: <20170703093452.GC16862@linux-l9pv.suse>
References: <20170621074544.18436-1-jlee@suse.com>
 <136250372.B1LmTaN194@aspire.rjw.lan>
 <20170630054907.GB13714@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:43030 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdGCJfF (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Mon, 3 Jul 2017 05:35:05 -0400
Content-Disposition: inline
In-Reply-To: <20170630054907.GB13714@linux-l9pv.suse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Michal Hocko <mhocko@suse.cz>

On Fri, Jun 30, 2017 at 01:49:07PM +0800, joeyli wrote:
> Hi Rafael,
> 
> On Thu, Jun 29, 2017 at 12:13:18AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, June 21, 2017 03:45:44 PM Lee, Chun-Yi wrote:
> > > In hotplug logic, it always indicates non-specific failure to
> > > platform through _OST when handing acpi hot-remove event failed. Then
> > > platform terminates the hot-remove process but it can not identify
> > > the reason.
> > > 
[...snip]
> > >  
> > > @@ -423,9 +433,8 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
> > >  		else
> > >  			goto out;
> > >  	}
> > > -	if (!error)
> > > -		ost_code = ACPI_OST_SC_SUCCESS;
> > 
> > I just would do:
> > 
> >     switch (error) {
> >     case 0:
> >         ost_code = ACPI_OST_SC_SUCCESS;
> >         break;
> >     case -EBUSY:
> >         ost_code = ACPI_OST_SC_DEVICE_BUSY;
> >         break;
> >     default:
> >         ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
> >         break;
> >     }
> >
> 
> Currently the above switch-case works. But if considering
> ACPI_OST_EC_OSPM_INSERTION in the future then it's not enough.
>

After more consideration...

Because Andy and Rafael gave the same suggestion and we didn't
see INSERTION event yet. I will follow the suggestion to send
v4 patch.

Thanks a lot!
Joey Lee
