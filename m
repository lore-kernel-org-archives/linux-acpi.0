From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] acpi ec_sys: Export fields of all regions from the EC
 to debugfs readable
Date: Fri, 30 Jul 2010 16:30:53 -0700
Message-ID: <20100730163053.bff43f26.akpm@linux-foundation.org>
References: <1280504824-8134-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44652 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753074Ab0G3XbF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jul 2010 19:31:05 -0400
In-Reply-To: <1280504824-8134-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: mjg59@srcf.ucam.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de

On Fri, 30 Jul 2010 17:47:04 +0200
Thomas Renninger <trenn@suse.de> wrote:

> -static int acpi_ec_open_io(struct inode *i, struct file *f)
> +static int acpi_ec_open(struct inode *i, struct file *f)
>  {
>  	f->private_data = i->i_private;
> +	if (mutex_trylock(&ec_fs_lock))
> +		return 0;
> +	else
> +		return -EBUSY;
> +}

Well that sucks - a userspace interface which is _designed_ to randomly
and rarely fail?

An application tries to open the thing and gets -EBUSY, what's it
supposed to do?  Sleep and try again?  Crash and dump core?

Also the code's uncommented, so the reader has no clue why a trylock
was used.  There are very few circumstances where any trylock can
acceptably be left uncommented.

afacit we can use mutex_lock() here and the implementation would be
heaps better.
