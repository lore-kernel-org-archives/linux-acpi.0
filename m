From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 14/23] usb-acpi: Comply with the ACPI API change
Date: Sat, 22 Sep 2012 22:54:41 -0700
Message-ID: <20120923055441.GA21084@kroah.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1348371388.git.len.brown@intel.com>
 <59e6423ba8aaa42289457a15ffc7d111a955a2fa.1348371388.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <59e6423ba8aaa42289457a15ffc7d111a955a2fa.1348371388.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>, Bob Moore <robert.moore@intel.com>, Matthew Garrett <mjg@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Sun, Sep 23, 2012 at 12:34:02AM -0400, Len Brown wrote:
> From: Feng Tang <feng.tang@intel.com>
> 
> acpi_get_physical_device_location()'s 2nd argument has been changed
> in ACPI implementaion, so need a follow-on change in
> usb_acpi_check_pld().
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Cc: Matthew Garrett <mjg@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Lan Tianyu <tianyu.lan@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
