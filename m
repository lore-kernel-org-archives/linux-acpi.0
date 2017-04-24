From: joeyli <jlee@suse.com>
Subject: Re: [PATCH v2] platform/x86: Add driver for INT0002 ACPI device
Date: Mon, 24 Apr 2017 17:19:42 +0800
Message-ID: <20170424091942.GN7636@linux-l9pv.suse>
References: <20170421125246.3982-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170421125246.3982-1-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Fri, Apr 21, 2017 at 02:52:46PM +0200, Hans de Goede wrote:
> Some peripherals on Baytrail and Cherrytrail platforms signal PME to the
> PMC to wakeup the system. When this happens software needs to clear the
> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
> 
> This is modelled in ACPI through the INT0002 ACPI device.
> 
> This commit adds a driver which will bind to that device, call the
> ACPI event handler for the wakeup and clear the interrupt source
> avoiding the irq storm.
> 
> Cc: joeyli <jlee@suse.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Takashi Iwai <tiwai@suse.de>
> ---
> Changes in v2:
> -Remove dev_err after malloc failure
> -Remove unused empty runtime pm callbacks
> -s/GPE0A_PME_/GPE0A_PME_B0_/
> -Fixed some checkpatch warnings (I forgot to run checkpatch on v1)

Please feel free to add:
	Reviewed-by: Joey Lee <jlee@suse.com>

Thanks a lot!
Joey Lee
