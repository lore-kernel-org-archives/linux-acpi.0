From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/7] x86 platform drivers: hp-wmi Use consistent prefix string for messages.
Date: Mon, 24 May 2010 22:04:57 +0200
Message-ID: <201005242204.58240.trenn@suse.de>
References: <1274451495-10252-1-git-send-email-trenn@suse.de> <1274451495-10252-4-git-send-email-trenn@suse.de> <201005211114.54902.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201005211114.54902.dmitry.torokhov@gmail.com>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mjg@redhat.com, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday 21 May 2010 08:14:53 pm Dmitry Torokhov wrote:
> On Friday 21 May 2010 07:18:11 am Thomas Renninger wrote:
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > CC: mjg@redhat.com
> > CC: linux-acpi@vger.kernel.org
> > CC: platform-driver-x86@vger.kernel.org
> > ---
> >  drivers/platform/x86/hp-wmi.c |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/platform/x86/hp-wmi.c
> > b/drivers/platform/x86/hp-wmi.c index 7b086dd..e04715a 100644
> > --- a/drivers/platform/x86/hp-wmi.c
> > +++ b/drivers/platform/x86/hp-wmi.c
> > @@ -52,6 +52,8 @@
> > MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4"); #define
> > HPWMI_WIRELESS_QUERY 0x5
> >  #define HPWMI_HOTKEY_QUERY 0xc
> >
> > +#define PREFIX "HP WMI: "
>
> Better yet, define pr_fmt() and  switch to using pr_info() and friends.
> dev_xxx() is another option too.

I would have to rediff the other patches...
As printk was already used, I'd appreciate if these can be merged and I can 
also fix this on top.

Thanks,

      Thomas
