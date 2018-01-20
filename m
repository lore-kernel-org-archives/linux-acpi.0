From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: ACPI: sbshc: remove raw pointer from printk message
Date: Sat, 20 Jan 2018 09:16:39 +0100
Message-ID: <20180120081639.GB21147@kroah.com>
References: <20180119090603.GA7775@kroah.com>
 <CAJZ5v0jh7sUje5RcEJVT_bLM9u=9z0pbPBEWy=4k-tfKfKO-SQ@mail.gmail.com>
 <20180120073613.GB18663@kroah.com>
 <CAJZ5v0htCL_b6+Pn22Ce612MrBJ6D+4Jby58BdXxjSX_zmNjiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59794 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeATIQk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jan 2018 03:16:40 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0htCL_b6+Pn22Ce612MrBJ6D+4Jby58BdXxjSX_zmNjiw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wang Qize <wang_qize@venustech.com.cn>

On Sat, Jan 20, 2018 at 09:03:33AM +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 20, 2018 at 8:36 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sat, Jan 20, 2018 at 12:53:39AM +0100, Rafael J. Wysocki wrote:
> >> On Fri, Jan 19, 2018 at 10:06 AM, Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >> > There's no need to be printing a raw kernel pointer to the kernel log at
> >> > every boot.  So just remove it, and change the whole message to use the
> >> > correct dev_info() call at the same time.
> >> >
> >> > Reported-by: Wang Qize <wang_qize@venustech.com.cn>
> >> > Cc: stable <stable@vger.kernel.org>
> >>
> >> I will remember this one. ;-)
> >>
> >> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>
> >> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Does that mean you want me to take this through my tree?  Or is there an
> > acpi tree it will go through?
> 
> I thought you'd push it, but I can take it, of course.  For 4.16, though.

4.16 is fine, the issue has been around for a very long time, no rush :)

