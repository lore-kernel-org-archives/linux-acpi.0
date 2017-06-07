From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] acpi: handle the acpi hotplug schedule error
Date: Wed, 7 Jun 2017 23:39:33 +0800
Message-ID: <20170607153933.GY30622@linux-l9pv.suse>
References: <20170607060527.23407-1-jlee@suse.com>
 <CAHp75Vdeagae37PHoD4yw4dncFQJ2tmuxRu0zzbH_b+SnY4pEQ@mail.gmail.com>
 <20170607101832.GW30622@linux-l9pv.suse>
 <CAHp75VcBG-gHEOPkPBHMXzpY7G3hJxtXKKAjPesjBHVW-gx6qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcBG-gHEOPkPBHMXzpY7G3hJxtXKKAjPesjBHVW-gx6qA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 07, 2017 at 01:46:37PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 7, 2017 at 1:18 PM, joeyli <jlee@suse.com> wrote:
> > On Wed, Jun 07, 2017 at 11:36:55AM +0300, Andy Shevchenko wrote:
> >> On Wed, Jun 7, 2017 at 9:05 AM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >> > Kernel should decrements the reference count of acpi device
> >> > when scheduling acpi hotplug work is failed, and also evaluates
> >> > _OST to notify BIOS the failure.
> 
> > So, do you mean like this?
> 
> Yes, see below.
> 
> >
> >         -       if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> >         -               return;
> >         +       if (hotplug_event) {
> 
> >         +               if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> >         +                       return;
> 
> >         +               else
> 
> It's redundant...
>

Oh~ Yes, you are right. The 'else' can be removed
 
> >         +                       goto err_put_device;
> 
> ...perhaps
> 
>          if (ACPI_FAILURE(acpi_hotplug_schedule(adev, type)))
>                  goto err_put_device;
>          return;
> 

I think normally it should be success. So how about:

	if (hotplug_event) {
		if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
			return;
		goto err_put_device;
	}
 
> >
> >                 acpi_bus_put_acpi_device(adev);
> >                 return;
> >
> >         +err_put_device:
> >         +       acpi_bus_put_acpi_device(adev);
> >          err:
> >                 acpi_evaluate_ost(handle, type, ost_code, NULL);
> >         }

Thanks a lot!
Joey Lee
