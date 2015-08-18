From: Huang Shijie <shijie.huang-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/3] Honor ACPI _CCA attribute setting
Date: Tue, 18 Aug 2015 11:36:55 +0800
Message-ID: <20150818033655.GB9990@free64-pc.asiapac.arm.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
 <1439416290-21228-2-git-send-email-jeremy.linton@arm.com>
 <55CD4832.7070301@amd.com>
 <55CDF74C.3050703@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55CDF74C.3050703-5wv7dgnIgG8@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeremy Linton <jeremy.linton-5wv7dgnIgG8@public.gmane.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org" <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 14, 2015 at 09:12:28AM -0500, Jeremy Linton wrote:
> Hello Suravee,
> 
> On 08/13/2015 08:45 PM, Suravee Suthikulpanit wrote:
> > On 8/13/15 04:51, Jeremy Linton wrote:
> >> ACPI configurations can now mark devices as noncoherent,
> >> support that choice.
> >
> > This change was in my earlier revisions for the original patch series to
> > add ACPI CCA support. At the time, this was pushed back since we were
> > not sure whether this would be a useful case, and whether such hardware
> > exists.
> 
> Yes, I was made aware of that conversation during the review here.
> 
> Basically, the ARM Juno development platform has a mix of coherent and 
> noncoherent devices. The EHCI being one of the primary noncoherent 
> peripherals. Without which, the usefulness of the platform for 
> developing with an ACPI kernel is limited.
> 
Tesed-by: Huang Shijie <shijie.huang-5wv7dgnIgG8@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
