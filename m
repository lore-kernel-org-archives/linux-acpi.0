From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC] power/hibernate: Make passing hibernate offsets more friendly
Date: Wed, 28 Feb 2018 20:11:18 +0200
Message-ID: <CAHp75VcdsALCUBNoO4BoOj0rHuxurhr6B3GL2i7D79BxRL77kQ@mail.gmail.com>
References: <1519839829-2191-1-git-send-email-mario.limonciello@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519839829-2191-1-git-send-email-mario.limonciello@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 28, 2018 at 7:43 PM, Mario Limonciello
<mario.limonciello@dell.com> wrote:
> Currently the only way to specify a hibernate offset for a swap
> file is on the kernel command line.
>
> This makes some changes to improve:
> 1) Add a new /sys/power/disk_offset that lets userspace specify
> the offset and disk to use when initiating a hibernate cycle.
>
> 2) Adjust /sys/power/resume interpretation to also read in an
> offset.

Read is okay per se (not consistent though), showing is not.
It might break an ABI.

> Actually klibc's /bin/resume has supported passing a hibernate
> offset in since 20695264e21dcbde309cd81f73cfe2cea42e779d.
>
> The kernel was just lobbing anything after the device specified
> off the string.  Instead parse that and populate hibernate offset
> with it.

> An alternative to introducing a new sysfs parameter may be to document
> setting these values via /sys/power/resume.  If the wrong signature is found
> on the swapfile/swap partition by the kernel it does show an error
> but it updates the values and they'll work when actually invoked later.

Don't you need to document new node?

> +static int parse_device_input(const char *buf, size_t n)
>  {
> +       unsigned long long offset;
>         dev_t res;
>         int len = n;
>         char *name;
> +       char *last;
>
>         if (len && buf[len-1] == '\n')
>                 len--;

I'm not sure first part even needed, but okay, it's in original code.

>         name = kstrndup(buf, len, GFP_KERNEL);
>         if (!name)
>                 return -ENOMEM;

Side notes.
This whole dance b/c of high probability of '\n' at the end which
breaks _some_ kernel parsers.
It might make sense to do a wrapper and call the guts of this function
with or without memory allocation depending on presence of '\n'.

> -

This is not needed to be removed.

> +       last = strrchr(name, ':');

> +       printk("%lu %s %s %d", last-name, name, last, len);

Ouch. I guess it's only for RFC.

> +       if (last != NULL &&

> +           (last-name) != len-1 &&

> +           sscanf(last+1, "%llu", &offset) == 1)

This is effectively

if (last && *(last+1)) {
  int ret = kstrtoull(...&swsusp_resume_block...);
  if (ret)
   ...warn?..
}

?

> +                swsusp_resume_block = offset;

> +       swsusp_resume_device = res;
> +

> +       return 1;

???
Why not traditional 0?

> +}

> @@ -1125,7 +1161,6 @@ static int __init pm_disk_init(void)
>
>  core_initcall(pm_disk_init);
>
> -

This doesn't belong to the change.

-- 
With Best Regards,
Andy Shevchenko
