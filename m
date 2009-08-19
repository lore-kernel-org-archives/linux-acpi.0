From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] [PATCH v3 1/2] introduce ALS sysfs class
Date: Wed, 19 Aug 2009 09:01:44 -0700
Message-ID: <20090819160144.GB1020@kroah.com>
References: <1250671229.17853.51.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752754AbZHSQJT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1250671229.17853.51.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 19, 2009 at 04:40:29PM +0800, Zhang Rui wrote:
> --- /dev/null
> +++ linux-2.6/Documentation/ABI/testing/sysfs-class-als
> @@ -0,0 +1,137 @@
> +Ambient Light Sensor Sysfs driver How To
> +=========================

<snip>

While this is a nice document, it does not follow the standard that the
files in Documentation/ABI/ should be in.  Can you please read
Documentation/ABI/README and convert the file to follow that?

thanks,

greg k-h
