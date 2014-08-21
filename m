From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI: Add GPIO-signaled event emulator.
Date: Thu, 21 Aug 2014 17:54:05 +0300
Message-ID: <20140821145405.GU1660@lahna.fi.intel.com>
References: <1408546700-19309-1-git-send-email-tomasz.nowicki@linaro.org>
 <20140821104533.GM1660@lahna.fi.intel.com>
 <53F604B2.6020004@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53F604B2.6020004@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: rjw@rjwysocki.net, linus.walleij@linaro.org, gnurou@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 21, 2014 at 04:39:46PM +0200, Tomasz Nowicki wrote:
> >>+{
> >>+	struct gpio_pin_data *pin_data, *temp;
> >>+
> >>+	list_for_each_entry_safe(pin_data, temp, &pin_data_list, list)
> >>+		kfree(pin_data);
> >
> >I suppose you want to first remove the directory entries and then the
> >pin data. Otherwise if you get pre-empted at this point and someone
> >tries to use your debugfs files, bad things might happen.
> Good catch!
> 
> >
> >>+
> >>+	debugfs_remove_recursive(acpi_evt_debugfs_dir);
> >
> >Since this already removes everything below this dentry, why do you need
> >to store the pointer in gpio_pin_parent_data?
> Not sure I got the question.
> 
> GPIO device instance (debugfs dir) is parent for all its pins (debugfs
> nodes). I am using gpio_pin_parent_data as container to pass info for all
> children so I can create debugfs node inside of parent related debugfs dir.
> 
> pin_data_list, however, is used to keep pointers to allocated memory (one
> for each pins). debugfs_remove_recursive won't free it.

Yes but it removes the debugfs entries below so you don't need to store
the children debugfs dentries.
