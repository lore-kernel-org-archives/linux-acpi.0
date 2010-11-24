From: Corentin Chary <corentin.chary@gmail.com>
Subject: debugfs_create_dir return value in acer-wmi, intel_ips and ec_sys
Date: Thu, 25 Nov 2010 00:51:06 +0100
Message-ID: <4ceda4f7.0cedd80a.26b4.0222@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, Julia Lawall <julia@diku.dk>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Matthew Garrett <mjg@redhat.com>, Axel Lin <axel.lin@gmail.com>, Thomas Renninger <trenn@suse.de>Thomas Renninger <trenn@suse.de>
List-Id: linux-acpi@vger.kernel.org

Hi,

I was checking debugfs code in platform/x86, because I want to add
some files to eeepc-wmi. And I found something disturbing.

The documentation says:

> This call, if successful, will make a directory called name underneath the
> indicated parent directory.  If parent is NULL, the directory will be
> created in the debugfs root.  On success, the return value is a struct
> dentry pointer which can be used to create files in the directory (and to
> clean it up at the end).  A NULL return value indicates that something went
> wrong.  If ERR_PTR(-ENODEV) is returned, that is an indication that the
> kernel has been built without debugfs support and none of the functions
> described below will work.

But then, here is the code in acer-wmi:

> static void remove_debugfs(void)
> {
>       debugfs_remove(interface->debug.devices);
>       debugfs_remove(interface->debug.root);
> }
>
> static int create_debugfs(void)
> {
>        interface->debug.root = debugfs_create_dir("acer-wmi", NULL);
>        if (!interface->debug.root) {
>                printk(ACER_ERR "Failed to create debugfs directory");
>                return -ENOMEM;
>        }

this code is *not* inside #ifndef CONFIG_DEBUG_FS, so debugfs_create_dir
can return ERR_PTR(-ENODEV) right ?

Then, remove_debug() will call debugfs_remove(ERR_PTR(-ENODEV)) right ?

So, acpi-wmi seems to have an issue when debugfs is disabled, that's "ok".

But then I took a look at intel_ips :

>        ips->debug_root = debugfs_create_dir("ips", NULL);
>        if (!ips->debug_root) {
>                dev_err(&ips->dev->dev,
>                        "failed to create debugfs entries: %ld\n",
>                        PTR_ERR(ips->debug_root));
>                return;
>        }

Then PTR_ERR thing is strange, because ips->debug_root can only be NULL 
here...
But here, it's ok to only check NULL, because it's inside #ifndef 
CONFIG_DEBUG_FS.

So, two drivers checked, to weird error handling code. I did a quick grep and 
opened
the first result: ec_sys.c.

ec_sys.c depends on CONFIG_ACPI_EC_DEBUGFS but doesn't depend on
CONFIG_DEBUG_FS.

Here, again, the code only check for != NULL while it could be ERR_PTR(-
ENODEV):

>        if (ec_device_count == 0) {
>                acpi_ec_debugfs_dir = debugfs_create_dir("ec", NULL);
>                if (!acpi_ec_debugfs_dir)
>                        return -ENOMEM;
>        }
>
>        sprintf(name, "ec%u", ec_device_count);
>        dev_dir = debugfs_create_dir(name, acpi_ec_debugfs_dir);

Here, acpi_ec_debugfs_dir (that can be an invalid pointer) is used as
a parent dentry, and will be dereferenced without checks.

I am missing something obvious, or are most of debugfs implementation
broken when debugfs is disabled ?

Julia, if I am right, coccinelle could help us right ? Can the tool check
if the code is between #ifdef CONFIG_DEBUGS_FS ? That would help a lot.

Thanks,
--
Corentin Chary
http://xf.iksaif.net
