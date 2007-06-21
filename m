From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] acpi choose sleep state help
Date: Thu, 21 Jun 2007 00:14:27 -0700
Message-ID: <200706210014.28707.david-b@pacbell.net>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com> <200706191352.16913.rjw@sisk.pl> <1182320280.30540.4.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:42265 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753706AbXFUHeU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 03:34:20 -0400
In-Reply-To: <1182320280.30540.4.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>

On Tuesday 19 June 2007, Shaohua Li wrote:
> > > +int acpi_pm_choose_sleep_state(acpi_handle handle, pm_message_t state)
> > > +{
> > 
> > The second argument doesn't seem to be used.  Is that intentional and if so,
> > then why?

That's what the platform hook API uses.  It is indeed a
useless parameter.  Removing it should be a separate patch.


> I hope it gives the suspend state, but it appears it's not used.

Eventually the API should be fixed to not include a pm_message_t ...
which should be called a "message" not a "state" (in every driver!).


