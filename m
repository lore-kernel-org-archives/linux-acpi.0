From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 1/3] debugfs: Add .fsync() callback proxy support
Date: Tue, 19 Jul 2016 08:13:19 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC04E9A@SHSMSX101.ccr.corp.intel.com>
References: <cover.1468464391.git.lv.zheng@intel.com>
 <66cf2476a5b8c421055b8ccc07d6114b0a131d3e.1468464391.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <66cf2476a5b8c421055b8ccc07d6114b0a131d3e.1468464391.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

Hi, Greg

Sorry for the noise.
It's better to use ioctl to implement this functionality.
Please ignore this series.
It's already possible to implement ioctl for a debugfs file.

Thanks and best regards
-Lv

> From: Zheng, Lv
> Subject: [PATCH 1/3] debugfs: Add .fsync() callback proxy support
> 
> This patch adds .fsync() callback for debugfs files.
> ACPI AML debugger needs to implement this to flush cmds/logs.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/debugfs/file.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 592059f..f863a0c 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -172,6 +172,10 @@ FULL_PROXY_FUNC(unlocked_ioctl, long, filp,
>  		PROTO(struct file *filp, unsigned int cmd, unsigned long
> arg),
>  		ARGS(filp, cmd, arg));
> 
> +FULL_PROXY_FUNC(fsync, int, filp,
> +		PROTO(struct file *filp, loff_t start, loff_t end, int datasync),
> +		ARGS(filp, start, end, datasync));
> +
>  static unsigned int full_proxy_poll(struct file *filp,
>  				struct poll_table_struct *wait)
>  {
> @@ -226,6 +230,8 @@ static void __full_proxy_fops_init(struct
> file_operations *proxy_fops,
>  		proxy_fops->poll = full_proxy_poll;
>  	if (real_fops->unlocked_ioctl)
>  		proxy_fops->unlocked_ioctl = full_proxy_unlocked_ioctl;
> +	if (real_fops->fsync)
> +		proxy_fops->fsync = full_proxy_fsync;
>  }
> 
>  static int full_proxy_open(struct inode *inode, struct file *filp)
> --
> 1.7.10
