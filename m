From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 06/10] ACPI: call acpi_debug_init() explicitly rather
 than  as initcall
Date: Tue, 24 Mar 2009 16:20:44 -0700
Message-ID: <49C96ACC.5090405@kernel.org>
References: <20090324224834.1262.65260.stgit@bob.kio> <20090324225003.1262.39890.stgit@bob.kio> <86802c440903241608q65dd0d94i794dbbef7bf7d586@mail.gmail.com> <200903241715.53690.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59554 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbZCXXVJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Mar 2009 19:21:09 -0400
In-Reply-To: <200903241715.53690.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Zhao Yakui <yakui.zhao@intel.com>

Bjorn Helgaas wrote:
> On Tuesday 24 March 2009 05:08:12 pm Yinghai Lu wrote:
>> On Tue, Mar 24, 2009 at 3:50 PM, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>>> This patch makes acpi_init() call acpi_debug_init() directly.
>>> Previously, both were subsys_initcalls.  acpi_debug_init()
>>> must happen after acpi_init(), and it's better to call it
>>> explicitly rather than rely on link ordering.
>>>
>>> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>>> ---
>>>  drivers/acpi/bus.c      |    1 +
>>>  drivers/acpi/debug.c    |   14 ++++++--------
>>>  drivers/acpi/internal.h |    6 ++++++
>>>  3 files changed, 13 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>>> index c133072..f32cfd6 100644
>>> --- a/drivers/acpi/bus.c
>>> +++ b/drivers/acpi/bus.c
>>> @@ -883,6 +883,7 @@ static int __init acpi_init(void)
>>>        acpi_ec_init();
>>>        acpi_power_init();
>>>        acpi_system_init();
>>> +       acpi_debug_init();
>>>        return result;
>>>  }
>>>
>>> diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
>>> index 20223cb..9cb189f 100644
>>> --- a/drivers/acpi/debug.c
>>> +++ b/drivers/acpi/debug.c
>>> @@ -297,17 +297,15 @@ acpi_system_write_debug(struct file *file,
>>>
>>>        return count;
>>>  }
>>> +#endif
>>>
>>> -static int __init acpi_debug_init(void)
>>> +int __init acpi_debug_init(void)
>>>  {
>>> +#ifdef CONFIG_ACPI_PROCFS
>>>        struct proc_dir_entry *entry;
>>>        int error = 0;
>>>        char *name;
>>>
>>> -
>>> -       if (acpi_disabled)
>>> -               return 0;
>>> -
>>>        /* 'debug_layer' [R/W] */
>>>        name = ACPI_SYSTEM_FILE_DEBUG_LAYER;
>>>        entry =
>>> @@ -338,7 +336,7 @@ static int __init acpi_debug_init(void)
>>>        remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LAYER, acpi_root_dir);
>>>        error = -ENODEV;
>>>        goto Done;
>>> -}
>>> -
>>> -subsys_initcall(acpi_debug_init);
>>> +#else
>>> +       return 0;
>>>  #endif
>>> +}
>>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>>> index 4a35f6e..44b8402 100644
>>> --- a/drivers/acpi/internal.h
>>> +++ b/drivers/acpi/internal.h
>>> @@ -3,6 +3,12 @@
>>>  int acpi_scan_init(void);
>>>  int acpi_system_init(void);
>>>
>>> +#ifdef CONFIG_ACPI_DEBUG
>> ==> #if defined(CONFIG_ACPI_DEBUG) && defined(CONFIG_ACPI_PROCFS)
> 
> I could do that, and leave the #ifdefs in debug.c as they were,
> but I thought it was cleaner to make it so that if we compile debug.c
> (i.e., CONFIG_ACPI_DEBUG=y), it always provides acpi_debug_init().
> 
> I moved the #ifdefs in debug.c so that acpi_debug_init() is a no-op
> if CONFIG_ACPI_PROCFS=n.
> 
> So I think my patch already addressed your concern, but let me
> know if not.

you had two copy
+#else
> > +       return 0;
> >  #endif
...

with
#if defined(CONFIG_ACPI_DEBUG) && defined(CONFIG_ACPI_PROCFS) 
in .h

you only need to do
>>> -
>>> -       if (acpi_disabled)
>>> -               return 0;
>>> -
>>>        /* 'debug_layer' [R/W] */
>>>        name = ACPI_SYSTEM_FILE_DEBUG_LAYER;
>>>        entry =
>>> @@ -338,7 +336,7 @@ static int __init acpi_debug_init(void)
>>>        remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LAYER, acpi_root_dir);
>>>        error = -ENODEV;
>>>        goto Done;
>>> -}
>>> -
>>> -subsys_initcall(acpi_debug_init);

in debug.c

totally you will have less one #ifdef

YH



