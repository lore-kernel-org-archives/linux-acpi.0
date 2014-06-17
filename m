From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] ACPI/Battery: Retry to get Battery information if failed
 during probing
Date: Mon, 16 Jun 2014 18:27:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1406161827320.21018@chino.kir.corp.google.com>
References: <1402552946-14704-1-git-send-email-tianyu.lan@intel.com> <alpine.DEB.2.02.1406112354070.23724@chino.kir.corp.google.com> <53995488.20308@intel.com> <alpine.DEB.2.02.1406120025050.23724@chino.kir.corp.google.com> <53996152.2000407@intel.com>
 <alpine.DEB.2.02.1406121415150.8305@chino.kir.corp.google.com> <539A60FC.1050301@intel.com> <alpine.DEB.2.02.1406131445130.31981@chino.kir.corp.google.com> <539E528B.90908@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <539E528B.90908@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, naszar@ya.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 16 Jun 2014, Lan Tianyu wrote:

> >> How about this?
> >>
> >> -       result = acpi_battery_update(battery, false);
> >> -       if (result)
> >> +
> >> +       /*
> >> +        * Some machines'(E,G Lenovo Z480) ECs are not stable
> >> +        * during boot up and this causes battery driver fails to be
> >> +        * probed due to failure of getting battery information
> >> +        * from EC sometimes. After several retries, the operation
> >> +        * may work. So add retry code here and 20ms sleep between
> >> +        * every retries.
> >> +        */
> >> +       while (acpi_battery_update(battery, false) && retry--)
> >> +               msleep(20);
> >> +       if (!retry) {
> >> +               result = -ENODEV;
> >>                 goto fail;
> >> +       }
> >> +
> > 
> > I think you want --retry and not retry--.
> 
> My original purpose is to retry 5 times after the first try fails.
> If use "--retry" here, it just retries 4 times.
> 
> >  Otherwise it's possible for the 
> > final call to acpi_battery_update() to succeed and now it's returning 
> > -ENODEV.
> > 
> 
> Yes, it maybe and I will change code like the following.
> 
> while ((result = acpi_battery_update(battery, false)) && retry--)
>        msleep(20);
> if (result)
>        goto fail;
> 

Looks good.
